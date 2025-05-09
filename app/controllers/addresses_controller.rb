class AddressesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_address, only: %i[ show edit update destroy ]
  layout "admin"

  # GET /addresses or /addresses.json
  def index
    @addresses = Address.all
    @address = Address.new
  end

  # GET /addresses/1 or /addresses/1.json
  def show
  end

  # GET /addresses/new
  def new
    @address = Address.new
  end

  # GET /addresses/1/edit
  def edit
  end

  # POST /addresses or /addresses.json
  def create
    # @address = Address.new(address_params)
    p params, '.......  ..........'

    count = params[:address][:count].to_i
    count = 1 if count < 1

    count.times do
      key = Eth::Key.new
      @address = Address.new(
        network: 0, # 假设以太坊主网
        address: key.address.to_s,
        pri_key_encrypted: key.private_hex, # 生产环境需加密
        status: 0,
        user_id: current_user.id # 假设使用第一个用户，实际需根据需求调整
      )

      unless @address.save
        flash[:alert] = "Failed to generate address: #{@address.errors.full_messages.join(', ')}"
        return render :new, status: :unprocessable_entity
      end
    end

    respond_to do |format|
      if @address.save
        format.html { redirect_to addresses_path, notice: "Address was successfully created." }
        # format.json { render :show, status: :created, location: @address }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /addresses/1 or /addresses/1.json
  def update
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to @address, notice: "Address was successfully updated." }
        format.json { render :show, status: :ok, location: @address }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /addresses/1 or /addresses/1.json
  def destroy
    @address.destroy!

    respond_to do |format|
      format.html { redirect_to addresses_path, status: :see_other, notice: "Address was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Address.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def address_params
      params.expect(address: [:address])
    end
end
