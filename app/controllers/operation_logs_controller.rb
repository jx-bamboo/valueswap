class OperationLogsController < ApplicationController
  before_action :set_operation_log, only: %i[ show edit update destroy ]

  # GET /operation_logs or /operation_logs.json
  def index
    @operation_logs = OperationLog.all
  end

  # GET /operation_logs/1 or /operation_logs/1.json
  def show
  end

  # GET /operation_logs/new
  def new
    @operation_log = OperationLog.new
  end

  # GET /operation_logs/1/edit
  def edit
  end

  # POST /operation_logs or /operation_logs.json
  def create
    @operation_log = OperationLog.new(operation_log_params)

    respond_to do |format|
      if @operation_log.save
        format.html { redirect_to @operation_log, notice: "Operation log was successfully created." }
        format.json { render :show, status: :created, location: @operation_log }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @operation_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /operation_logs/1 or /operation_logs/1.json
  def update
    respond_to do |format|
      if @operation_log.update(operation_log_params)
        format.html { redirect_to @operation_log, notice: "Operation log was successfully updated." }
        format.json { render :show, status: :ok, location: @operation_log }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @operation_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /operation_logs/1 or /operation_logs/1.json
  def destroy
    @operation_log.destroy!

    respond_to do |format|
      format.html { redirect_to operation_logs_path, status: :see_other, notice: "Operation log was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_operation_log
      @operation_log = OperationLog.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def operation_log_params
      params.expect(operation_log: [ :operation_type, :detail, :ip, :user_agent, :user_id ])
    end
end
