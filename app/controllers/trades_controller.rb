require "ostruct"
require "binance"
class TradesController < ApplicationController
  before_action :authenticate_user!
	# before_action :ensure_admin
  before_action :set_trade, only: %i[ show edit update destroy ]
  layout "admin"

  # GET /trades or /trades.json
  def index
    @trades = Trade.all
  end

  # GET /trades/1 or /trades/1.json
  def show
  end

  # GET /trades/new
  def new
    @trade = Trade.new
    @users = User.all
    @user_exchanges = @trade.user_id ? UserExchange.where(user_id: @trade.user_id) : []
    @coins = @trade.user_exchange_id ? Coin.where(exchange_id: @trade.user_exchange&.exchange_id) : []
  end

  # GET /trades/1/edit
  def edit
  end

  # POST /trades or /trades.json
  def create
    p params, '... params ...'
    @trade = Trade.new(trade_params)
    @trade.trade_type = 'manual'
    @trade.exchange_id = @trade.user_exchange.exchange_id
    @trade.executed_at = Time.current
    @trade.admin_id = current_user.id
    key = @trade.user_exchange.api_key
    secret = @trade.user_exchange.api_secret
    api_success = false
    
    if @trade.user_exchange.exchange.name == 'binance'
      begin
        c = Binance::Spot.new(key:, secret:, recv_window: 10000)
        res = c.new_order(
          symbol: "#{Coin.find(params[:trade][:coin_id]).symbol}USDT", 
          side: params[:trade][:side].upcase, 
          price: params[:trade][:price], 
          quantity: params[:trade][:quantity], 
          type: params[:trade][:order_type].upcase, 
          timeInForce: 'GTC'
        )
        if res && res.any?
          @trade.ex_json = res
          api_success = true
        else
          @trade.errors.add(:base, "获取 Binance 订单失败")
        end
      rescue Binance::ClientError => e
        Rails.logger.error "Binance API error: #{e.message}"
        parse_binance_error(e)
        @trade.errors.add(:base, parse_binance_error(e))
      rescue => e 
        Rails.logger.error "Binance 订单失败: #{e.message}"
        @trade.errors.add(:base, "Binance 订单失败: #{e.message}")
      end
    end
    @trade.order_id = SecureRandom.uuid
    
    respond_to do |format|
      if api_success && @trade.save
        format.html { redirect_to @trade, notice: "Trade was successfully created." }
        format.json { render :show, status: :created, location: @trade }
      else
        @users = User.all
        @user_exchanges = @trade.user_id ? UserExchange.where(user_id: @trade.user_id) : []
        @coins = [] # 初始为空，由 Stimulus 动态加载
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @trade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trades/1 or /trades/1.json
  def update
    respond_to do |format|
      if @trade.update(trade_params)
        format.html { redirect_to @trade, notice: "Trade was successfully updated." }
        format.json { render :show, status: :ok, location: @trade }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @trade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trades/1 or /trades/1.json
  def destroy
    @trade.destroy!

    respond_to do |format|
      format.html { redirect_to trades_path, status: :see_other, notice: "Trade was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # 返回用户交易所
  def exchanges_by_user
    user = User.find(params[:user_id])
    exchanges = user.exchanges # 通过 UserExchange 关联
    render json: exchanges.map { |e| { id: e.id, name: e.name } }
  end

  # 返回交易所支持的币种
  def coins_by_exchange
    exchange = Exchange.find(params[:exchange_id])
    coins = exchange.coins # 通过 ExchangeCoin 关联
    render json: coins.map { |c| { id: c.id, symbol: c.symbol } }
  end

  # 返回用户绑定的交易所
  def exchanges_for_user
    user_exchanges = UserExchange.where(user_id: params[:user_id]).includes(:exchange)
    render json: user_exchanges.map { |ue| { id: ue.id, exchange_name: ue.exchange.name } }
  end

  # 返回交易所支持的币种
  def coins_for_user_exchange
    user_exchange = UserExchange.find(params[:user_exchange_id])
    coins = ExchangeCoin.where(exchange_id: user_exchange.exchange_id).map(&:coin)
    render json: coins.map { |coin| { id: coin.id, symbol: coin.symbol } }
  end

  # 获取价格，余额
  def coin_info
    user_exchange = UserExchange.find(params[:user_exchange_id])
    coin = Coin.find(params[:coin_id])
    unless user_exchange.exchange.name == 'binance'
      return render json: { error: "仅支持 Binance 交易所" }, status: :unprocessable_entity
    end
    begin
      c = Binance::Spot.new(key: user_exchange.api_key, secret: user_exchange.api_secret, recv_window: 10000)
      balance_info = c.get_user_asset(asset: "#{coin.symbol}").first || {:free => "0"}
      price_info = c.ticker_price(symbol: "#{coin.symbol}USDT") || {:price => "0"}
      render json: {
        balance: balance_info[:free].to_f,
        price: price_info[:price].to_f.round(2)
      }
    rescue Binance::ClientError => e
      Rails.logger.error "Binance API error: #{e.message}"
      parse_binance_error(e)
      render json: { error: "无法获取币种信息：#{parse_binance_error(e)}" }, status: :unprocessable_entity
    rescue => e
      Rails.logger.error "Unexpected error: #{e.message}"
      render json: { error: "无法获取币种信息：#{e.message}" }, status: :unprocessable_entity
    end
  end

  def open 
    @trade = Trade.new
    @users = User.all
    render :open
  end

  def open_create
    @trade = Trade.new(trade_params)
    @trade.trade_type = 'open'
    @trade.executed_at = Time.current
    @trade.admin_id = current_user.id
    @trade.order_id = SecureRandom.uuid

    if @trade.user_exchange
      @trade.exchange_id = @trade.user_exchange.exchange_id
    else
      @trade.errors.add(:user_exchange_id, "必须选择一个有效的交易所账户")
      return render json: { error: "必须选择一个有效的交易所账户" }, status: :unprocessable_entity
    end

    if @trade.errors.empty? && @trade.user_exchange&.exchange&.name == 'binance'
      begin
        key = @trade.user_exchange.api_key
        secret = @trade.user_exchange.api_secret
        c = Binance::Spot.new(key: key, secret: secret)

        asset = params[:trade][:asset]
        unless asset.present?
          @trade.errors.add(:base, "无效的资产")
          return render json: { error: "无效的资产" }, status: :unprocessable_entity
        end

        symbol = "#{asset}USDT".upcase
        side = params[:trade][:side]&.upcase
        order_type = params[:trade][:order_type]&.upcase
        price = params[:trade][:price].to_f
        quantity = params[:trade][:quantity].to_f

        unless side.in?(%w[BUY SELL])
          @trade.errors.add(:side, "必须是 BUY 或 SELL")
          return render json: { error: "无效的交易方向" }, status: :unprocessable_entity
        end
        unless order_type.in?(%w[LIMIT MARKET])
          @trade.errors.add(:order_type, "必须是 LIMIT 或 MARKET")
          return render json: { error: "无效的订单类型" }, status: :unprocessable_entity
        end

        account_info = c.get_user_asset
        available_usdt = account_info.find { |a| a["asset"] == "USDT" }&.fetch("free", "0").to_f
        available_asset = account_info.find { |a| a["asset"] == asset }&.fetch("free", "0").to_f

        required_amount = side == "BUY" ? price * quantity : quantity
        available_amount = side == "BUY" ? available_usdt : available_asset
        fee_estimate = required_amount * 0.001

        unless available_amount >= required_amount + fee_estimate
          @trade.errors.add(:base, "账户余额不足：需要 #{required_amount + fee_estimate} #{side == 'BUY' ? 'USDT' : asset}, 可用 #{available_amount}")
          return render json: { error: "账户余额不足，请检查可用余额" }, status: :unprocessable_entity
        end

        res = c.new_order(
          symbol: symbol,
          side: side,
          price: price,
          quantity: quantity,
          type: order_type,
          timeInForce: order_type == 'LIMIT' ? 'GTC' : nil
        )

        if res && res["orderId"]
          @trade.ex_json = res
          @trade.order_id = res["orderId"]
        else
          @trade.errors.add(:base, "Binance API 返回无效数据")
          return render json: { error: "Binance API 返回无效数据" }, status: :unprocessable_entity
        end
      rescue Binance::ClientError => e
        Rails.logger.error "Binance API error: #{e.message}"
        @trade.errors.add(:base, parse_binance_error(e))
        return render json: { error: parse_binance_error(e) }, status: :unprocessable_entity
      rescue => e
        Rails.logger.error "Unexpected error: #{e.message}"
        @trade.errors.add(:base, "创建订单失败：#{e.message}")
        return render json: { error: "创建订单失败：#{e.message}" }, status: :unprocessable_entity
      end
    elsif @trade.user_exchange
      @trade.errors.add(:base, "不支持的交易所：#{@trade.user_exchange.exchange.name}")
      return render json: { error: "不支持的交易所" }, status: :unprocessable_entity
    end

    if @trade.errors.empty? && @trade.save
      render json: { message: "交易创建成功" }, status: :created
    else
      render json: { error: @trade.errors.full_messages.join("; ") }, status: :unprocessable_entity
    end
  end

  #获取用户交易所的资产信息, turbo
  def assets_for_user_exchange
    Rails.logger.debug "Params: #{params.inspect}"
    @user_exchange = UserExchange.find(params[:user_exchange_id])
    @assets = []

    unless @user_exchange.exchange.name == 'binance'
      flash.now[:alert] = "不支持的交易所"
      Rails.logger.info "Unsupported exchange: #{@user_exchange.exchange.name}"
      return render partial: "trades/open_assets_list", locals: { assets: @assets, user_exchange: @user_exchange }, layout: false
    end

    begin
      client = Binance::Spot.new(key: @user_exchange.api_key, secret: @user_exchange.api_secret, recv_window: 10000)
      account_info = client.get_user_asset
      Rails.logger.debug "Binance account_info: #{account_info.inspect}"
      @assets = account_info
        .select { |a| a[:free].to_f > 0 }
        .map { |a| OpenStruct.new(asset: a[:asset], balance: a[:free].to_f.round(8)) }
      Rails.logger.debug "Processed assets: #{@assets.inspect}"
    rescue Faraday::ConnectionFailed, Faraday::SSLError, Errno::ECONNRESET => e
      Rails.logger.error "Network error connecting to Binance API: #{e.message}"
      flash.now[:alert] = "无法连接到 Binance API：#{e.message}. 请检查网络或 API 密钥。"
      @assets = []
    rescue Binance::ClientError => e
      Rails.logger.error "Binance API error: #{e.message}"
      flash.now[:alert] = parse_binance_error(e)
      @assets = []
    end

    respond_to do |format|
      format.html { render partial: "trades/open_assets_list", locals: { assets: @assets, user_exchange: @user_exchange }, layout: false, status: :ok }
    end
  end

  # def assets_for_user_exchange
  #   p params, '--- params ---'
  #   @user_exchange = UserExchange.find(params[:user_exchange_id]) rescue nil
  #   # 硬编码测试资产
  #   @assets = [
  #     OpenStruct.new(asset: "BNB", balance: 2.512485, price: 500.12345678),
  #     OpenStruct.new(asset: "BTC", balance: 0.12345678, price: 60000.0)
  #   ]
  #   Rails.logger.debug "Test assets: #{@assets.inspect}"

  #   respond_to do |format|
  #     format.html { render partial: "trades/open_assets_list", locals: { assets: @assets, user_exchange: @user_exchange }, layout: false, status: :ok }
  #   end
  # end

  # 获取用户交易所的资产信息, stimulus
  def assets_by_user_exchange
    user_exchange = UserExchange.find(params[:user_exchange_id])

    unless user_exchange.exchange.name == 'binance'
      return render json: [], status: :unprocessable_entity
    end

    begin
      c = Binance::Spot.new(key: user_exchange.api_key, secret: user_exchange.api_secret)
      res = c.get_user_asset
      p res,'-- -- -- --'
      assets = res.select { |a| a[:free].to_f > 0 }

      assets = assets.map do |asset|
        price_info = c.avg_price(symbol: "#{asset[:asset]}USDT".upcase) rescue { "price" => "0" }
        {
          asset: asset[:asset],
          free: asset[:free].to_f.round(8),
          price: price_info[:price].to_f.round(8)
        }
      end

      render json: assets
    rescue Binance::ClientError => e
      Rails.logger.error "Binance API error: #{e.message}"
      render json: [], status: :unprocessable_entity
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trade
      @trade = Trade.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def trade_params
      # params.expect(trade: [ :trade_type, :action, :price, :quantity, :fee, :status, :profit_loss, :order_id, :executed_at, :admin_id, :user_id, :user_exchange_id, :coin_id ])
      params.require(:trade).permit(
      :user_id,
      :user_exchange_id,
      :coin_id,
      :trade_type,
      :side,
      :order_type,
      :price,
      :quantity,
      :leverage,
      :position_side
    )
    end
		
		def parse_binance_error(error)
      begin
        # 提取 body
        body_hash = extract_error_body(error.message)
        if body_hash.nil?
          Rails.logger.error "Failed to extract body from: #{error.message}"
          return "无法解析 Binance 错误"
        end
    
        # 提取 code 和 msg
        code = body_hash["code"]
        msg = body_hash["msg"]
    
        # 记录日志
        Rails.logger.error "Binance API error: code=#{code}, msg=#{msg}"
    
        # 返回用户提示
        case code
        when -2010
          "账户余额不足，请检查可用余额"
        when -1021
          "请求时间戳无效，请检查本地时间或增加 recvWindow"
        when -1121
          "无效的交易对，请选择正确的币种"
        when -1102
          "订单参数错误，请检查价格或数量"
        when -2015
          "API 密钥无效、IP 未授权或权限不足，请检查密钥设置"
        else
          "Binance 错误：#{msg}"
        end
      rescue => e
        Rails.logger.error "Unexpected error in parse_binance_error: #{e.message}"
        "未知错误：#{error.message}"
      end
    end
    
    # 提取 body 方法
    def extract_error_body(error_message)
      body_match = error_message.match(/body: "({.*?})"/)
      return nil unless body_match
    
      begin
        JSON.parse(body_match[1].gsub(/\\"/, '"'))
      rescue JSON::ParserError
        Rails.logger.error "Failed to parse body JSON: #{body_match[1]}"
        nil
      end
    end

    def render_new_with_errors
      @users = User.all
      render :new, status: :unprocessable_entity
    end
end
