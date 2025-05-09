require "rqrcode"
class ProfileController < ApplicationController
  before_action :authenticate_user!
  def index
    exchange_api
    p @exchanges_api, '------------------'

    my_address
    
  end

  def ex_form
    @user_exchange = UserExchange.new
  end

  def create_user_exchange
    @user_exchange = UserExchange.new(
      api_key: params[:user_exchange][:api_key],
      api_secret: params[:user_exchange][:api_secret],
      memo: params[:user_exchange][:memo],
      user_id: current_user.id,
      exchange_id: params[:user_exchange][:exchange_id]
    )
    if @user_exchange.save
      render turbo_stream: [
        turbo_stream.replace("ex_api", partial: "profile/ex_api", locals: { exchanges_api: exchange_api }),
      ]
    else
      redirect_to profile_index_path, notice: @user_exchange.errors.full_messages.join(", ")
    end
  end

  # app/controllers/profile_controller.rb
def apply_address
  addr = Address.where(status: 0).lock("FOR UPDATE").first # 添加锁防止并发
  if addr.nil?
    respond_to do |format|
      format.html { redirect_to profile_index_path, notice: "暂时没有可用地址！" }
      format.turbo_stream { render turbo_stream: turbo_stream.append("messages", partial: "shared/notice", locals: { message: "暂时没有可用地址！" }) }
    end
    return
  end

  p addr, '---------- addr --------', addr.id, addr.address
  
  user_addr = UserAddress.new(
    network: 0,
    w_address: addr.address, # 以太坊地址字符串
    symbol: "eth",
    name: "ethereum",
    balance: 0,
    user_id: current_user.id,
    address_id: addr.id    # Address 记录的 ID
  )

  p user_addr, '---------- user_address --------'
  addr.status = 1 # 更新地址状态

  p addr, '---------- addr --------'

  ActiveRecord::Base.transaction do
    user_addr.save!
    addr.save!
  end

  my_address # 设置 @data
  unless @data
    redirect_to profile_index_path, alert: "无法加载地址数据！"
    return
  end

  respond_to do |format|
    format.html { redirect_to profile_index_path, notice: "地址绑定成功！" }
    format.turbo_stream do
      render turbo_stream: turbo_stream.replace("w_add", partial: "profile/w_add", locals: { data: @data })
    end
  end
rescue ActiveRecord::RecordInvalid, ActiveRecord::Base::StatementInvalid => e
  Rails.logger.debug "Error: #{e.message}"
  respond_to do |format|
    format.html { redirect_to profile_index_path, alert: "绑定地址失败：#{e.message}" }
    format.turbo_stream { render turbo_stream: turbo_stream.append("messages", partial: "shared/notice", locals: { message: "绑定地址失败：#{e.message}" }) }
  end
end


  def invite 
  end

  def record 
  end


  private 
  def exchange_api 
    @exchanges_api = current_user.user_exchanges.includes(:exchange)
  end

  def my_address 
    @my_address = current_user.user_address
    return unless @my_address.present?

    address = @my_address.w_address
    qrcode = RQRCode::QRCode.new(address)

    # NOTE: showing with default options specified explicitly
    img = qrcode.as_svg(
      color: "DFF0FF",
      shape_rendering: "crispEdges",
      module_size: 6,
      standalone: true,
      use_path: true
    )
    @data = {
      img:,
      address:
    }
  end
end
