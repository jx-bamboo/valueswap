class AirdropsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_airdrop, only: %i[ show edit update destroy ]
  layout 'admin'

  # GET /airdrops or /airdrops.json
  def index
    @airdrops = Airdrop.all
  end

  # GET /airdrops/1 or /airdrops/1.json
  def show
  end

  # GET /airdrops/new
  def new
    @airdrop = Airdrop.new
  end

  # GET /airdrops/1/edit
  def edit
  end

  # POST /airdrops or /airdrops.json
  def create
    @airdrop = Airdrop.new(airdrop_params)
    @airdrop.user = current_user

    respond_to do |format|
      if @airdrop.save
        format.html { redirect_to @airdrop, notice: "Airdrop was successfully created." }
        format.json { render :show, status: :created, location: @airdrop }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @airdrop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /airdrops/1 or /airdrops/1.json
  def update
    respond_to do |format|
      if @airdrop.update(airdrop_params)
        format.html { redirect_to @airdrop, notice: "Airdrop was successfully updated." }
        format.json { render :show, status: :ok, location: @airdrop }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @airdrop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /airdrops/1 or /airdrops/1.json
  def destroy
    @airdrop.destroy!

    respond_to do |format|
      format.html { redirect_to airdrops_path, status: :see_other, notice: "Airdrop was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_airdrop
      @airdrop = Airdrop.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def airdrop_params
      params.expect(airdrop: [ :name, :symbol, :logo, :intro, :official_web, :total_amount, :reward_amount, :network, :tag, :begin_time, :end_time, :status ])
    end
end
