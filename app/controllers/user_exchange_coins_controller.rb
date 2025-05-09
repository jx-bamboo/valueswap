class UserExchangeCoinsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_exchange_coin, only: [:show, :edit, :update, :destroy]

  layout "admin"

  # 列出某个用户交易所下的所有绑定币种
  def index
    # @user_exchange = UserExchange.find(params[:user_exchange_id])
    # @user_exchange_coins = @user_exchange.user_exchange_coins.includes(:coin)
    # @user_exchange_coins = UserExchangeCoin.includes(:user, :exchange, :coin).all
    @grouped_user_exchange_coins = UserExchangeCoin.includes(:user, :exchange, :coin).all.group_by { |uec| uec.user.email }
  end

  # 显示添加币种绑定的表单
  def new
    @user_exchange_coin = UserExchangeCoin.new
  end

  def show
  end

  # 创建新的币种绑定
  def create
    p params, '------            ---'
    # @user_exchange_coin = UserExchangeCoin.new(user_exchange_coin_params)
    # if @user_exchange_coin.save
    #   redirect_to user_exchange_coins_path(@user_exchange), notice: '币种绑定成功！'
    # else
    #   render :new
    # end

    @user_exchange_coin = UserExchangeCoin.new(user_exchange_coin_params)
    @user_exchange_coin.last_updated = Time.current

    # 验证币种是否被交易所支持
    unless ExchangeCoin.exists?(exchange_id: @user_exchange_coin.exchange_id, coin_id: @user_exchange_coin.coin_id)
      @user_exchange_coin.errors.add(:coin_id, "选择的币种不被该交易所支持")
      return render :new, status: :unprocessable_entity
    end

    if @user_exchange_coin.save
      redirect_to @user_exchange_coin, notice: "币种绑定成功。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # 显示编辑币种绑定的表单
  def edit
  end

  # 更新币种绑定信息
  def update
    if @user_exchange_coin.update(user_exchange_coin_params)
      redirect_to user_exchange_coins(@user_exchange_coin.user_exchange), notice: '币种信息更新成功！'
    else
      render :edit
    end
  end

  # 删除币种绑定
  def destroy
    @user_exchange_coin.destroy!
    respond_to do |format|
      format.html { redirect_to user_exchange_coins_path, status: :see_other, notice: "币种绑定已删除！" }
      format.json { head :no_content }
    end
  end

   # 返回用户绑定的交易所
   def exchanges_for_user
    exchanges = UserExchange.where(user_id: params[:user_id]).map(&:exchange)
    render json: exchanges.map { |ex| { id: ex.id, name: ex.name } }
  end

  # 返回交易所支持的币种
  def coins_for_exchange
    coins = ExchangeCoin.where(exchange_id: params[:exchange_id]).map(&:coin)
    render json: coins.map { |coin| { id: coin.id, name: coin.symbol } }
  end

  private

  # 设置用户交易所币种绑定
  def set_user_exchange_coin
    @user_exchange_coin = UserExchangeCoin.find(params[:id])
  end

  # 允许的参数
  def user_exchange_coin_params
    params.require(:user_exchange_coin).permit(:exchange_id, :coin_id, :user_id, :coin_id)
  end

end
