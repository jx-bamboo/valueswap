require "binance"
class ExchangeBalancesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_exchange_balance, only: %i[ show edit update destroy ]
  layout "admin"

  # GET /exchange_balances or /exchange_balances.json
  def index
    @exchange_balances = ExchangeBalance.includes(:user, :user_exchange).all
  end

  # GET /exchange_balances/1 or /exchange_balances/1.json
  def show
  end

  # GET /exchange_balances/new
  def new
    @exchange_balance = ExchangeBalance.new
  end

  # GET /exchange_balances/1/edit
  def edit
  end

  # POST /exchange_balances or /exchange_balances.json
  def create
    @exchange_balance = ExchangeBalance.new(exchange_balance_params)
    user_exchange = UserExchange.find(params[:exchange_balance][:user_exchange_id])
    exchange, key, secret = user_exchange.exchange.name, user_exchange.api_key, user_exchange.api_secret
    api_success = false

    if exchange == 'binance'
      begin
        c = Binance::Spot.new(key:, secret:)
        res = c.wallet_balance(quoteAsset: 'USDT')
        if res && res.any?
          @exchange_balance.ex_json = res
          @exchange_balance.spot = res[0][:balance]
          @exchange_balance.funding = res[1][:balance]
          @exchange_balance.usd_futures = res[4][:balance]
          api_success = true
        else
          @exchange_balance.errors.add(:base, "获取 Binance 钱包余额失败")
        end
      rescue => e 
        Rails.logger.error "获取 Binance 钱包余额失败: #{e.message}"
        @exchange_balance.errors.add(:base, "获取 Binance 钱包余额失败: #{e.message}")
      end
    elsif exchange == 'okx'
    else
      @exchange_balance.errors.add(:base, "不支持的交易所: #{exchange}")
    end

    respond_to do |format|
      if api_success && @exchange_balance.save
        format.html { redirect_to @exchange_balance, notice: "Exchange balance was successfully created." }
        format.json { render :show, status: :created, location: @exchange_balance }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @exchange_balance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exchange_balances/1 or /exchange_balances/1.json
  def update
    respond_to do |format|
      if api_success && @exchange_balance.update(exchange_balance_params)
        format.html { redirect_to @exchange_balance, notice: "Exchange balance was successfully updated." }
        format.json { render :show, status: :ok, location: @exchange_balance }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @exchange_balance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exchange_balances/1 or /exchange_balances/1.json
  def destroy
    @exchange_balance.destroy!

    respond_to do |format|
      format.html { redirect_to exchange_balances_path, status: :see_other, notice: "Exchange balance was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exchange_balance
      @exchange_balance = ExchangeBalance.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def exchange_balance_params
      # params.fetch(:exchange_balance, {})
			params.expect(exchange_balance: [ :user_id, :user_exchange_id ])
    end
end
