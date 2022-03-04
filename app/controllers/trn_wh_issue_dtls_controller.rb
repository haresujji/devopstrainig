class TrnWhIssueDtlsController < ApplicationController
  before_action :set_trn_wh_issue_dtl, only: [:show, :edit, :update, :destroy]

  # GET /trn_wh_issue_dtls
  # GET /trn_wh_issue_dtls.json
  def index
    @trn_wh_issue_dtls = TrnWhIssueDtl.all
  end

  # GET /trn_wh_issue_dtls/1
  # GET /trn_wh_issue_dtls/1.json
  def show
  end

  # GET /trn_wh_issue_dtls/new
  def new
    @trn_wh_issue_dtl = TrnWhIssueDtl.new
  end

  # GET /trn_wh_issue_dtls/1/edit
  def edit
  end

  # POST /trn_wh_issue_dtls
  # POST /trn_wh_issue_dtls.json
  def create
    @trn_wh_issue_dtl = TrnWhIssueDtl.new(trn_wh_issue_dtl_params)

    respond_to do |format|
      if @trn_wh_issue_dtl.save
        format.html { redirect_to @trn_wh_issue_dtl, notice: 'Trn wh issue dtl was successfully created.' }
        format.json { render :show, status: :created, location: @trn_wh_issue_dtl }
      else
        format.html { render :new }
        format.json { render json: @trn_wh_issue_dtl.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trn_wh_issue_dtls/1
  # PATCH/PUT /trn_wh_issue_dtls/1.json
  def update
    respond_to do |format|
      if @trn_wh_issue_dtl.update(trn_wh_issue_dtl_params)
        format.html { redirect_to @trn_wh_issue_dtl, notice: 'Trn wh issue dtl was successfully updated.' }
        format.json { render :show, status: :ok, location: @trn_wh_issue_dtl }
      else
        format.html { render :edit }
        format.json { render json: @trn_wh_issue_dtl.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trn_wh_issue_dtls/1
  # DELETE /trn_wh_issue_dtls/1.json
  def destroy
    @trn_wh_issue_dtl.destroy
    respond_to do |format|
      format.html { redirect_to trn_wh_issue_dtls_url, notice: 'Trn wh issue dtl was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trn_wh_issue_dtl
      @trn_wh_issue_dtl = TrnWhIssueDtl.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trn_wh_issue_dtl_params
      params.require(:trn_wh_issue_dtl).permit(:wh_loc_id,:issue_docno,:rfid_tag,:mat_desc,:mat_uom,:sap_batch,:mat_code,:issued_qty,:trn_wh_issue_hdr,:source_plant,:source_str_loc,:mat_group,:tran_type,:sup_roll_ref,:vendor_code,:vendor_name,:expiry_dt)
    end
end
