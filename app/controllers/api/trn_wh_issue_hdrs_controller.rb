class Api::TrnWhIssueHdrsController < Api::ApiController
  before_action :authenticate_user
  before_action :set_trn_wh_issue_hdr, only: [:show, :edit, :update, :destroy]

  # GET /trn_wh_issue_hdrs/new
  def new
    @trn_wh_issue_hdr = TrnWhIssueHdr.new
  end

  # POST /trn_wh_issue_hdrs
  # POST /trn_wh_issue_hdrs.json

  def update_mat_request(req_no,mat_code)
    mat_request_hdr = TrnMatRequisitionHdr.find_by(req_no:req_no)
    mat_request_dtl = TrnMatRequisitionItem.find_by(mat_code:mat_code,trn_mat_requisition_hdr_id:mat_request_hdr.id)
      if mat_request_dtl
        mat_request_dtl.update(status:'completed')
      end
  end

  # POST /trn_wh_issue_hdrs
  # POST /trn_wh_issue_hdrs.json
   def create
    begin
      @trn_wh_issue_hdr = TrnWhIssueHdr.new(trn_wh_issue_hdrs_params)
      sap_batch = {}
      sup_roll_ref = {}
      issued_qty =0
        records = trn_wh_issue_hdrs_params[:trn_wh_issue_dtls_attributes].each do |a|
          sap_batch = a['sap_batch']
          sup_roll_ref = a['sup_roll_ref']
          qty = a['issued_qty']      
          issued_qty = issued_qty+=qty.to_f
        end
        balance_qty = TrnWipStock.find_by(sap_batch:sap_batch,vendor_batch:sup_roll_ref)
        if issued_qty.to_f > balance_qty.bal_qty.to_f
          render json: {status:"error", "message": "Location does not contain requested qty "}, status: :internal_server_error
        elsif issued_qty.to_f == balance_qty.bal_qty.to_f  
          @trn_wh_issue_hdr = TrnWhIssueHdr.new(trn_wh_issue_hdrs_params)
          @trn_wh_issue_hdr.save
           update_mat_request(@trn_wh_issue_hdr.req_no,@trn_wh_issue_hdr.mat_code)
          render json: @trn_wh_issue_hdr, status: :created
          @trn_wh_issue_hdr.update(action_status:'closed') 
        else
          @trn_wh_issue_hdr = TrnWhIssueHdr.new(trn_wh_issue_hdrs_params)
          @trn_wh_issue_hdr.save
          update_mat_request(@trn_wh_issue_hdr.req_no,@trn_wh_issue_hdr.mat_code)
          render json: @trn_wh_issue_hdr, status: :created
          @trn_wh_issue_hdr.update(action_status:'active')
        end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end


  # PATCH/PUT /trn_wh_issue_hdrs/1
  # PATCH/PUT /trn_wh_issue_hdrs/1.json
  def update
    begin
      status = params[:event] == "submit" ? 'closed' : 'active'
      params = trn_wh_issue_hdrs_param
      params[:action_status] = status
      if @trn_wh_issue_hdr.update(params)
        render json: @trn_wh_issue_hdr, status: :ok
      else
        render json: {status: "error", message: @trn_wh_issue_hdr.errors.full_messages.first}, status: :unprocessable_entity 
      end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trn_wh_issue_hdr
      @trn_wh_issue_hdr = TrnWhIssueHdr.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trn_wh_issue_hdrs_params
      trn_wh_issue_hdrs_params = params.require(:trn_wh_issue_hdr).except(:id,:trn_wh_issue_hdr_id).permit(:plant, :str_loc,:to_plant,:to_str_loc, :req_no, :req_dt, :mat_group,:mat_uom,:mat_desc,:mat_code,:required_qty,:issued_qty,:issue_docno,:issue_docdt, :user_id, :action_status, { trn_wh_issue_dtls_attributes: [:wh_loc_id,:rfid_tag,:mat_desc,:mat_group,:mat_code,:mat_uom,:sap_batch,:issued_qty,:source_plant,:source_str_loc,:sup_roll_ref,:expiry_dt,:vendor_code,:vendor_name,:tran_type]})
    end

    def trn_wh_issue_hdrs_param
      trn_wh_issue_hdrs_param = params.require(:trn_wh_issue_hdr).permit(:plant, :str_loc,:to_plant,:to_str_loc, :req_no, :req_dt, :mat_group,:mat_uom,:mat_desc,:mat_code,:required_qty,:issued_qty,:issue_docno,:issue_docdt, :user_id, :action_status, { trn_wh_issue_dtls_attributes: [:id,:trn_wh_issue_hdr_id,:wh_loc_id,:rfid_tag,:mat_desc,:mat_group,:mat_code,:mat_uom,:sap_batch,:issued_qty,:source_plant,:source_str_loc,:sup_roll_ref,:expiry_dt,:vendor_code,:vendor_name,:tran_type]})
    end
end
