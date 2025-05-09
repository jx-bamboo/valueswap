class UserExchangesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_exchange, only: %i[ show edit update destroy ]

	layout "admin"

  # GET /user_exchanges or /user_exchanges.json
  def index
    # @user_exchanges = UserExchange.includes(:user, :exchange).all
    @grouped_exchanges = UserExchange.includes(:user, :exchange).all.group_by { |ue| ue.user.email }
  end

  # GET /user_exchanges/1 or /user_exchanges/1.json
  def show
    @exchange_balances = @user_exchange.exchange_balances
  end

  # GET /user_exchanges/new
  def new
    @user_exchange = UserExchange.new
  end

  # GET /user_exchanges/1/edit
  def edit
  end

  # POST /user_exchanges or /user_exchanges.json
  def create
    @user_exchange = UserExchange.new(user_exchange_params)

    respond_to do |format|
      if @user_exchange.save
        format.html { redirect_to @user_exchange, notice: "Exchange was successfully created." }
        format.json { render :show, status: :created, location: @user_exchange }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_exchange.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_exchanges/1 or /user_exchanges/1.json
  def update
    respond_to do |format|
      if @user_exchange.update(user_exchange_params)
        format.html { redirect_to @user_exchange, notice: "Coin was successfully updated." }
        format.json { render :show, status: :ok, location: @user_exchange }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_exchange.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_exchanges/1 or /user_exchanges/1.json
  def destroy
    @user_exchange.destroy!

    respond_to do |format|
      format.html { redirect_to user_exchanges_path, status: :see_other, notice: "User Exchange was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def by_user
    user_id = params[:user_id]
    @user_exchanges = user_id.present? ? UserExchange.where(user_id: user_id) : []
    render json: @user_exchanges.map { |ue| { id: ue.id, name: ue.exchange.name } }
  end

  private   
    # Use callbacks to share common setup or constraints between actions.
    def set_user_exchange
      @user_exchange = UserExchange.find(params[:id])
    end
    # Only allow a list of trusted parameters through.
    def user_exchange_params
      params.require(:user_exchange).permit(:api_key, :api_secret, :memo, :status, :user_id, :exchange_id)
    end
    
    
end
