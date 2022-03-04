class Api::TrnMatReceiptsController < Api::ApiController
  before_action :authenticate_user
  before_action :set_trn_mat_receipt, only: [:show, :edit, :destroy]
  before_action :set_trn_mat_receipts, only: [:update, :mat_receipt]


  # GET /trn_mat_receipts/new
  def new
    @trn_mat_receipt = TrnMatReceipt.new
  end

  def update_issue_status(req_no,mat_code,rfid_tag)
   
    issue_dtl = TrnWhIssueDtl.where("mat_code=? and rfid_tag=? and status=?",mat_code,rfid_tag,'active')
      if issue_dtl
        issue_dtl.update(status:'completed')
      end
  end


  # POST /trn_mat_receipts
  # POST /trn_mat_receipts.json
  def create
    begin
      trn_mat_receipt = TrnMatReceipt.find_by(rfid_tag: params[:rfid_tag],mat_code:params[:mat_code],req_no:params[:req_no])
      status =  params[:event] == 'submit' ? 'closed' : 'active'
      params = trn_mat_receipt_params 
      params[:action_status] = status  
        if trn_mat_receipt && trn_mat_receipt.action_status == 'active'
          trn_mat_receipt.update_attributes(trn_mat_receipt_params)
          render json: trn_mat_receipt, status: :ok
        else
          @trn_mat_receipt = TrnMatReceipt.new(trn_mat_receipt_params)
          @trn_mat_receipt.save
          update_issue_status( @trn_mat_receipt.req_no,@trn_mat_receipt.mat_code,@trn_mat_receipt.rfid_tag)
          render json: @trn_mat_receipt, status: :created
        end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def mat_receipts
    puts 'hello'
    @successArray = []
    records = params['list_receipt'].each do |a|
      result_sets = TrnMatReceipt.find_by(rfid_tag:a['rfid_tag'],action_status: 'active')
      if result_sets
        # want to add update method
      else       
      @trn_mat_receipt =   TrnMatReceipt.create!(from_plant:a['from_plant'],to_plant:a['to_plant'],from_str_loc:a['from_str_loc'],to_str_loc:a['to_str_loc'],tran_type:a['tran_type'],tran_ref_no:a['tran_ref_no'],
          rfid_tag:a['rfid_tag'],req_no:a['req_no'],mat_group:a['mat_group'],mat_code:a['mat_code'],mat_desc:a['mat_desc'],mat_uom:a['mat_uom'],mat_qty:a['mat_qty'],issue_qty:a['issue_qty'],received_qty:a['received_qty'],variance_qty:a['variance_qty'],
          issue_dt:a['issue_dt'],expiry_dt:a['expiry_dt'],sup_roll_ref:a['sup_roll_ref'],user_id:a['user_id'],mat_received_status:a['mat_received_status'],action_status:a['action_status'],sap_batch:a['sap_batch']) 
        
      update_issue_status( @trn_mat_receipt.req_no,@trn_mat_receipt.mat_code,@trn_mat_receipt.rfid_tag)
        @successArray.push(TrnMatReceipt.all.where('tran_ref_no=?',a['tran_ref_no']).where('mat_code=?',a['mat_code']).where('rfid_tag=?',a['rfid_tag']).first)
      end
    end
    render json: @successArray, status: :created
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trn_mat_receipt_sto
      @trn_mat_receipts_sto = TrnMatReceipt.find_by(rfid_tag:params[:rfid_tag])
    end

    def set_trn_mat_receipt
      @trn_mat_receipt = TrnMatReceipt.find(params[:id])
    end

    def set_trn_mat_receipts
      @trn_mat_receipts = TrnMatReceipt.find_by(rfid_tag:params[:rfid_tag])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trn_mat_receipt_params
      trn_mat_receipt_params = params.require(:trn_mat_receipt)
                                     .permit( :from_plant,:from_str_loc,:action_status,:to_plant,:to_str_loc,:tran_type,:tran_ref_no,:rfid_tag,:req_no,:mat_group,:mat_code,:mat_desc,:mat_uom,:mat_qty,:issue_qty,:received_qty,:variance_qty,:issue_docdt,:sap_issue_batch,:expiry_dt,:sup_roll_ref,:user,:sap_batch,:mat_received_status,:tare_wt,:issue_dt)
    end

end
