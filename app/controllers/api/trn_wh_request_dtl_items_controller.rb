class Api::TrnWhRequestDtlItemsController < Api::ApiController
  before_action :authenticate_user
  before_action :set_trn_wh_request_dtl_item, only: [:show, :edit, :update, :destroy]

  # GET /trn_wh_request_dtl_items/new
  def new
    @trn_wh_request_dtl_item = TrnWhRequestDtlItem.new
  end


  def stock(issue_batch,source_plant,mat_code,vendor_batch,loaded_qty)
    wh_material_storage = WhMaterialStorage.find_by("sap_batch=? and plant=? and mat_code=? and vendor_batch=?",issue_batch,source_plant,mat_code,vendor_batch)
    picked_quantity =  wh_material_storage.wh_picked_qty.to_f + loaded_qty.to_f
    balance_quantity = wh_material_storage.wh_balance_qty.to_f - loaded_qty.to_f
      if wh_material_storage 
        if loaded_qty.to_f <= wh_material_storage.wh_balance_qty 
          wh_material_storage.wh_picked_qty = picked_quantity
          wh_material_storage.wh_balance_qty = balance_quantity
          wh_material_storage.save
       end
     end
  end

  def update_status(prq_docno,mat_code)
     trn_wh_request_dtl = TrnWhRequestDtl.find_by("prq_docno=? and mat_code=?",prq_docno,mat_code)
      if trn_wh_request_dtl
        trn_wh_request_dtl.update(action_status:'completed')
      end
  end


  # POST /trn_wh_request_dtl_items
  # POST /trn_wh_request_dtl_items.json
  def create
    begin
      @trn_wh_request_dtl_item = TrnWhRequestDtlItem.new
      @records = params['trn_wh_request_dtl_item'].each do |s|      
        TrnWhRequestDtlItem.create!(prq_docno:s['prq_docno'],delievery_dt:s['delievery_dt'],vendor_batch:s['vendor_batch'],
                           rfid_tag:s['rfid_tag'],source_plant:s['source_plant'],source_str_loc:s['source_str_loc'],to_plant:s['to_plant'],
                           to_str_loc:s['to_str_loc'],req_no:s['req_no'],req_dt:s['req_dt'],mat_group:s['mat_group'],mat_desc:s['mat_desc'],mat_code:s['mat_code'],mat_uom:s['mat_uom'],
                           required_qty:s['required_qty'],assigned_qty:s['assigned_qty'],loaded_qty:s['loaded_qty'],issue_batch:s['issue_batch'],
                           issue_batch_qty:s['issue_batch_qty'],tran_type:s['tran_type'],sto_ref:s['sto_ref'],sto_ref_pdf_path:s['sto_ref_pdf_path'],
                           sap_status:s['sap_status'],sap_err_msg:s['sap_err_msg'],sap_upd_dttime:s['sap_upd_dttime'],user_id:s['user_id'],action_status:'closed')
        stock(s['issue_batch'],s['source_plant'],s['mat_code'],s['vendor_batch'],s['loaded_qty'])
        update_status(s['prq_docno'],s['mat_code'])
      end
      render json:@records,status: 201
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def getStoDetails
    begin
      sto_number = params['sto_ref']
      warehouse = TrnWhRequestDtlItem.select('trn_wh_request_dtl_items.*')
                            .where('sto_ref=?',sto_number)
        if warehouse.blank?
          render json: {status:"error", "message": "No Matches Found for this period"}, status: :internal_server_error 
        else
          render json:warehouse
        end 
      
    rescue StandardError => e
            render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  
  end


  def warehouse_period_filter
    begin
      from = params['from']
      to = params['to']
      source_plant = params['source_plant']
      source_str_loc = params['source_str_loc']
      warehouse = TrnWhRequestDtlItem.select('distinct trn_wh_request_dtl_items.*')
                            .where('source_plant=? and source_str_loc=?',source_plant,source_str_loc)
                            .where("to_char(trn_wh_request_dtl_items.created_at,'yyyy-mm-dd')   between  ? AND ?",from,to)
        if warehouse.blank?
          render json: {status:"error", "message": "No Matches Found for this period"}, status: :internal_server_error 
        else
          render json:warehouse
        end 
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end


  def issue_hdrs_period_filter
    begin
      from = params['from']
      to = params['to']
      plant = params['plant']
      str_loc = params['str_loc']
      issues = TrnWhIssueHdr.select('trn_wh_issue_hdrs.*')
                            .where('plant=? and str_loc=?',plant,str_loc)
                            .where("to_char(trn_wh_issue_hdrs.created_at,'yyyy-mm-dd')   between  ? AND ?",from,to)
        if issues.blank?
          render json: {status:"error", "message": "No Matches Found for this period"}, status: :internal_server_error 
        else
        render :json => issues
        end 
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trn_wh_request_dtl_item
      @trn_wh_request_dtl_item = TrnWhRequestDtlItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trn_wh_request_dtl_item_params
      params.require(:trn_wh_request_dtl_item).permit(:prq_docno,:deliever_dt,:delievery_dt,:source_plant,:source_str_loc,:to_plant,:to_str_loc,:req_no,:req_dt,:mat_group,:mat_desc,:mat_code,:mat_uom,:required_qty,:assigned_qty,:loaded_qty,:issue_batch,:issue_batch_qty,:tran_type,:sto_ref,:sto_ref_pdf_path,:sap_status,:sap_err_msg,:sap_upd_dttime,:user_id,:action_status)
    end
end
