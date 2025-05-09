class ExchangeCoinsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_exchange_coin, only: %i[ show edit update destroy ]
  layout "admin"

  # GET /exchange_coins or /exchange_coins.json
  def index
    # @exchange_coins = ExchangeCoin.all
    @grouped_exchange_coins = ExchangeCoin.includes(:exchange, :coin).all.group_by { |ec| ec.exchange.name }
  end

  # GET /exchange_coins/1 or /exchange_coins/1.json
  def show
  end

  # GET /exchange_coins/new
  def new
    @exchange_coin = ExchangeCoin.new
  end

  # GET /exchange_coins/1/edit
  def edit
  end

  # POST /exchange_coins or /exchange_coins.json
  # def create
  #   @exchange_coin = ExchangeCoin.new(exchange_coin_params)

  #   respond_to do |format|
  #     if @exchange_coin.save
  #       format.html { redirect_to @exchange_coin, notice: "Exchange coin was successfully created." }
  #       format.json { render :show, status: :created, location: @exchange_coin }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @exchange_coin.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def create
    exchange_id = params[:exchange_coin][:exchange_id]
    coin_ids = params[:exchange_coin][:coin_ids]

    # 初始化错误数组和表单对象
    @errors = []
    @exchange_coin = ExchangeCoin.new(exchange_id: exchange_id)

    # 验证交易所
    if exchange_id.blank?
      @exchange_coin.errors.add(:exchange_id, "请选择一个交易所！")
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { errors: @errors }, status: :unprocessable_entity }
      end
      return
    end

    # 验证币种
    if coin_ids.nil? || coin_ids.empty?
      @exchange_coin.errors.add(:coin_id, "至少选一个！")
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { errors: @errors }, status: :unprocessable_entity }
      end
      return
    end

    # 批量创建
    success = true
    coin_ids.each do |coin_id|
      exchange_coin = ExchangeCoin.new(exchange_id: exchange_id, coin_id: coin_id)
      unless exchange_coin.save
        @errors << "币种 #{Coin.find_by(id: coin_id)&.symbol || coin_id} 绑定失败：#{exchange_coin.errors.full_messages.join(', ')}"
        success = false
      end
    end

    respond_to do |format|
      if success
        format.html { redirect_to exchange_coins_path, notice: "交易所币种关联创建成功。" }
        format.json { render json: { status: :created } }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { errors: @errors }, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exchange_coins/1 or /exchange_coins/1.json
  def update
    respond_to do |format|
      if @exchange_coin.update(exchange_coin_params)
        format.html { redirect_to @exchange_coin, notice: "Exchange coin was successfully updated." }
        format.json { render :show, status: :ok, location: @exchange_coin }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @exchange_coin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exchange_coins/1 or /exchange_coins/1.json
  def destroy
    @exchange_coin.destroy!

    respond_to do |format|
      format.html { redirect_to exchange_coins_path, status: :see_other, notice: "Exchange coin was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # def coins_for_exchange
  #   p params, "... ..."
  #   exchange_id = params[:exchange_id]
  #   coin_ids = ExchangeCoin.where(exchange_id: exchange_id).pluck(:coin_id)
  #   p coin_ids, "... coin_ids ..."
  #   render json: { coin_ids: coin_ids }
  # end

  def coins_for_exchange
    p params, "... ..."
    exchange_id = params[:exchange_id]
    @disabled_coin_ids = exchange_id.present? ? ExchangeCoin.where(exchange_id: exchange_id).pluck(:coin_id) : []
    
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "coins_frame",
          partial: "exchange_coins/coins",
          locals: { form: nil, disabled_coin_ids: @disabled_coin_ids }
        )
      end
      format.html do
        render partial: "exchange_coins/coins", locals: { form: nil, disabled_coin_ids: @disabled_coin_ids }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exchange_coin
      @exchange_coin = ExchangeCoin.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def exchange_coin_params
      # params.expect(exchange_coin: [ :exchange_id, coin_id: [] ])
      params.require(:exchange_coin).permit(:exchange_id, coin_id: [])

    end
end
