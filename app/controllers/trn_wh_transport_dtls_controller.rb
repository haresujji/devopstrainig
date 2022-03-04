class TrnWhTransportDtlsController < ApplicationController
  before_action :set_trn_wh_transport_dtl, only: [:show, :edit, :update, :destroy]

  # GET /trn_wh_transport_dtls
  # GET /trn_wh_transport_dtls.json
  def index
    @trn_wh_transport_dtls = TrnWhTransportDtl.all
  end

  # GET /trn_wh_transport_dtls/1
  # GET /trn_wh_transport_dtls/1.json
  def show
  end

  # GET /trn_wh_transport_dtls/new
  def new
    @trn_wh_transport_dtl = TrnWhTransportDtl.new
  end

  # GET /trn_wh_transport_dtls/1/edit
  def edit
  end

  # POST /trn_wh_transport_dtls
  # POST /trn_wh_transport_dtls.json
  def create
    @trn_wh_transport_dtl = TrnWhTransportDtl.new(trn_wh_transport_dtl_params)

    respond_to do |format|
      if @trn_wh_transport_dtl.save
        format.html { redirect_to @trn_wh_transport_dtl, notice: 'Trn wh transport dtl was successfully created.' }
        format.json { render :show, status: :created, location: @trn_wh_transport_dtl }
      else
        format.html { render :new }
        format.json { render json: @trn_wh_transport_dtl.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trn_wh_transport_dtls/1
  # PATCH/PUT /trn_wh_transport_dtls/1.json
  def update
    respond_to do |format|
      if @trn_wh_transport_dtl.update(trn_wh_transport_dtl_params)
        format.html { redirect_to @trn_wh_transport_dtl, notice: 'Trn wh transport dtl was successfully updated.' }
        format.json { render :show, status: :ok, location: @trn_wh_transport_dtl }
      else
        format.html { render :edit }
        format.json { render json: @trn_wh_transport_dtl.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trn_wh_transport_dtls/1
  # DELETE /trn_wh_transport_dtls/1.json
  def destroy
    @trn_wh_transport_dtl.destroy
    respond_to do |format|
      format.html { redirect_to trn_wh_transport_dtls_url, notice: 'Trn wh transport dtl was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trn_wh_transport_dtl
      @trn_wh_transport_dtl = TrnWhTransportDtl.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trn_wh_transport_dtl_params
      params.require(:trn_wh_transport_dtl).permit(:prq_docno,:transport_name,:driver_name,:driver_phone,:truck_number,:driver_licence,:bill_no,  
)
    end
end
