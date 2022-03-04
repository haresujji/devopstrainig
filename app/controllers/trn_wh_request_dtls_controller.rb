class TrnWhRequestDtlsController < ApplicationController
  before_action :set_trn_wh_request_dtl, only: [:show, :edit, :update, :destroy]

  # GET /trn_wh_request_dtls
  # GET /trn_wh_request_dtls.json
  def index
    @trn_wh_request_dtls = TrnWhRequestDtl.all
  end

  # GET /trn_wh_request_dtls/1
  # GET /trn_wh_request_dtls/1.json
  def show
  end

  # GET /trn_wh_request_dtls/new
  def new
    @trn_wh_request_dtl = TrnWhRequestDtl.new
  end

  # GET /trn_wh_request_dtls/1/edit
  def edit
  end

  # POST /trn_wh_request_dtls
  # POST /trn_wh_request_dtls.json
  def create
    @trn_wh_request_dtl = TrnWhRequestDtl.new(trn_wh_request_dtl_params)

    respond_to do |format|
      if @trn_wh_request_dtl.save
        format.html { redirect_to @trn_wh_request_dtl, notice: 'Trn wh request dtl was successfully created.' }
        format.json { render :show, status: :created, location: @trn_wh_request_dtl }
      else
        format.html { render :new }
        format.json { render json: @trn_wh_request_dtl.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trn_wh_request_dtls/1
  # PATCH/PUT /trn_wh_request_dtls/1.json
  def update
    respond_to do |format|
      if @trn_wh_request_dtl.update(trn_wh_request_dtl_params)
        format.html { redirect_to @trn_wh_request_dtl, notice: 'Trn wh request dtl was successfully updated.' }
        format.json { render :show, status: :ok, location: @trn_wh_request_dtl }
      else
        format.html { render :edit }
        format.json { render json: @trn_wh_request_dtl.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trn_wh_request_dtls/1
  # DELETE /trn_wh_request_dtls/1.json
  def destroy
    @trn_wh_request_dtl.destroy
    respond_to do |format|
      format.html { redirect_to trn_wh_request_dtls_url, notice: 'Trn wh request dtl was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trn_wh_request_dtl
      @trn_wh_request_dtl = TrnWhRequestDtl.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trn_wh_request_dtl_params
      params.require(:trn_wh_request_dtl).permit(:prq_docno,:source_plant,:source_str_loc,:to_plant,:to_str_loc,:req_no,:req_dt,:sequence_number,:mat_group,:mat_desc,:mat_code,:mat_uom,:required_qty,:assigned_qty,:loaded_qty,:issue_batch,:issue_batch_qty,:tran_type,:sto_ref,:sto_ref_pdf_path,:sap_status,:sap_err_msg,:sap_upd_dttime,:user_id,:action_status)
    end
end
