class WhStoDtlsController < ApplicationController
  before_action :set_wh_sto_dtl, only: [:show, :update, :destroy]

  # GET /wh_sto_dtls
  # GET /wh_sto_dtls.json
  def index
    @wh_sto_dtls = WhStoDtl.all
  end

  # GET /wh_sto_dtls/1
  # GET /wh_sto_dtls/1.json
  def show
  end

  # POST /wh_sto_dtls
  # POST /wh_sto_dtls.json
  def create
    @wh_sto_dtl = WhStoDtl.new(wh_sto_dtl_params)

    if @wh_sto_dtl.save
      render :show, status: :created, location: @wh_sto_dtl
    else
      render json: @wh_sto_dtl.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /wh_sto_dtls/1
  # PATCH/PUT /wh_sto_dtls/1.json
  def update
    if @wh_sto_dtl.update(wh_sto_dtl_params)
      render :show, status: :ok, location: @wh_sto_dtl
    else
      render json: @wh_sto_dtl.errors, status: :unprocessable_entity
    end
  end

  # DELETE /wh_sto_dtls/1
  # DELETE /wh_sto_dtls/1.json
  def destroy
    @wh_sto_dtl.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wh_sto_dtl
      @wh_sto_dtl = WhStoDtl.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wh_sto_dtl_params
      params.fetch(:wh_sto_dtl, {})
    end
end
