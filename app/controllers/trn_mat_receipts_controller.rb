class TrnMatReceiptsController < ApplicationController
  before_action :set_trn_mat_receipt, only: [:show, :edit, :update, :destroy]

  # GET /trn_mat_receipts
  # GET /trn_mat_receipts.json
  def index
    @trn_mat_receipts = TrnMatReceipt.all
  end

  # GET /trn_mat_receipts/1
  # GET /trn_mat_receipts/1.json
  def show
  end

  # GET /trn_mat_receipts/new
  def new
    @trn_mat_receipt = TrnMatReceipt.new
  end

  # GET /trn_mat_receipts/1/edit
  def edit
  end

  # POST /trn_mat_receipts
  # POST /trn_mat_receipts.json
  def create
    @trn_mat_receipt = TrnMatReceipt.new(trn_mat_receipt_params)

    respond_to do |format|
      if @trn_mat_receipt.save
        format.html { redirect_to @trn_mat_receipt, notice: 'Trn mat receipt was successfully created.' }
        format.json { render :show, status: :created, location: @trn_mat_receipt }
      else
        format.html { render :new }
        format.json { render json: @trn_mat_receipt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trn_mat_receipts/1
  # PATCH/PUT /trn_mat_receipts/1.json
  def update
    respond_to do |format|
      if @trn_mat_receipt.update(trn_mat_receipt_params)
        format.html { redirect_to @trn_mat_receipt, notice: 'Trn mat receipt was successfully updated.' }
        format.json { render :show, status: :ok, location: @trn_mat_receipt }
      else
        format.html { render :edit }
        format.json { render json: @trn_mat_receipt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trn_mat_receipts/1
  # DELETE /trn_mat_receipts/1.json
  def destroy
    @trn_mat_receipt.destroy
    respond_to do |format|
      format.html { redirect_to trn_mat_receipts_url, notice: 'Trn mat receipt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trn_mat_receipt
      @trn_mat_receipt = TrnMatReceipt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trn_mat_receipt_params
      params.require(:trn_mat_receipt).permit(:from_plant,:from_str_loc,:to_plant,:to_str_loc,:tran_type,:tran_ref_no,:rfid_tag,:req_no,:mat_group,:mat_code,:mat_desc,:mat_uom,:mat_qty,:issue_qty,:received_qty,:variance_qty,:issue_dt,:expiry_dt,:sup_roll_ref,:user_id,:sap_batch,:mat_received_status,:sap_docref,:sap_status,:sap_err_msg,:sap_trn_dttime,:sap_upd_dttime)
    end
end
