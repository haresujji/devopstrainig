class Api::TrnWhRequestDtlsController < Api::ApiController
  before_action :authenticate_user
  before_action :set_trn_wh_request_dtl, only: [:show, :edit, :update, :destroy]

  # GET /trn_wh_request_dtls/new
  def new
    @trn_wh_request_dtl = TrnWhRequestDtl.new
  end


  def update_mat_request(req_no,mat_code)
    mat_request_hdr = TrnMatRequisitionHdr.find_by(req_no:req_no)
    mat_request_dtl = TrnMatRequisitionItem.find_by(mat_code:mat_code,trn_mat_requisition_hdr_id:mat_request_hdr.id)
      if mat_request_dtl
        mat_request_dtl.update(status:'completed')
      end
  end

  # POST /trn_wh_request_dtls
  # POST /trn_wh_request_dtls.json
 def create
    begin
      @trn_wh_request_dtl = TrnWhRequestDtl.new
      @records = params['trn_wh_request_dtl']
      puts @records.to_json
      current_time = DateTime.now
      current_time_month = Time.now.strftime("%y%m")
      current_count = TrnWhRequestDtl
                                    .where("prq_docno like ?", "#{current_time_month}%")
                                    .count
      number = TrnWhRequestDtl.where("prq_docno like ?","#{current_time_month}%").maximum('sequence_number')
        if number 
          sequence_number = "%.5i" %(number +1)
          number = "#{number +1}"
        else
          sequence_number = "%.5i" %(current_count +1)
          number = "#{current_count +1}"
        end
        prq_docno = "#{current_time_month}#{@records[0]['source_plant']}#{sequence_number}"
        sequence_number =  "#{number}"       
      @records.each do |s|
        puts @records
        if s['tran_type'] == 'WH-ORDER-WH'
          prq_docno = s['prq_docno']  
        else
          TrnWhRequestDtl.create!(prq_docno:prq_docno,sequence_number:sequence_number,delievery_dt:s['delievery_dt'],source_plant:s['source_plant'],source_str_loc:s['source_str_loc'],to_plant:s['to_plant'],to_str_loc:s['to_str_loc'],req_no:s['req_no'],req_dt:s['req_dt'],mat_group:s['mat_group'],mat_desc:s['mat_desc'],mat_code:s['mat_code'],mat_uom:s['mat_uom'],required_qty:s['required_qty'],assigned_qty:s['assigned_qty'],loaded_qty:s['loaded_qty'],issue_batch:s['issue_batch'],issue_batch_qty:s['issue_batch_qty'],tran_type:s['tran_type'],sto_ref:s['sto_ref'],sto_ref_pdf_path:s['sto_ref_pdf_path'],sap_status:s['sap_status'],sap_err_msg:s['sap_err_msg'],sap_upd_dttime:s['sap_upd_dttime'],user_id:s['user_id'],action_status:'closed')
          update_mat_request(s['req_no'],s['mat_code'])
        end
      end
      @records = TrnWhRequestDtl.all.where('prq_docno=?',prq_docno)
      render json:@records,status: 200
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def fetch_receipt
    begin
      rfid_tag = params['rfid_tag']
      mat_desc = TrnWhIssueHdr.select('trn_wh_issue_hdrs.plant,trn_wh_issue_hdrs.issue_docdt,trn_wh_issue_hdrs.issue_docno,trn_wh_issue_hdrs.str_loc,trn_wh_issue_hdrs.to_plant,trn_wh_issue_hdrs.to_str_loc,trn_wh_issue_dtls.tran_type,trn_wh_issue_hdrs.req_no,trn_wh_issue_dtls.mat_group,trn_wh_issue_dtls.mat_code,
                               trn_wh_issue_dtls.mat_desc,trn_wh_issue_dtls.rfid_tag,trn_wh_issue_dtls.mat_uom,trn_wh_issue_dtls.issued_qty,trn_wh_issue_dtls.expiry_dt,trn_wh_issue_dtls.sup_roll_ref,trn_wh_issue_dtls.sap_batch')
                              .joins('INNER JOIN trn_wh_issue_dtls on trn_wh_issue_dtls.trn_wh_issue_hdr_id = trn_wh_issue_hdrs.id')
                              .where('trn_wh_issue_dtls.rfid_tag=? and trn_wh_issue_dtls.status=?',rfid_tag,'active').first
        if mat_desc.blank?
          render json: {status:"error", "message": "No Matches Found for this Rfid"}, status: :internal_server_error 
        else
          render json:mat_desc
        end 
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def fetch_receipt_security
    begin
      rfid_tag = params['rfid_tag']    
      mat_desc = TrnWhIssueHdr.select('trn_wh_issue_hdrs.plant,trn_wh_issue_hdrs.issue_docdt,trn_wh_issue_hdrs.issue_docno,trn_wh_issue_hdrs.str_loc,trn_wh_issue_hdrs.to_plant,trn_wh_issue_hdrs.to_str_loc,trn_wh_issue_dtls.tran_type,trn_wh_issue_hdrs.req_no,trn_wh_issue_dtls.mat_group,trn_wh_issue_dtls.mat_code,
                               trn_wh_issue_dtls.mat_desc,trn_wh_issue_dtls.rfid_tag,trn_wh_issue_dtls.mat_uom,trn_wh_issue_dtls.issued_qty,trn_wh_issue_dtls.expiry_dt,trn_wh_issue_dtls.sup_roll_ref,trn_wh_issue_dtls.sap_batch')
                              .joins('INNER JOIN trn_wh_issue_dtls on trn_wh_issue_dtls.trn_wh_issue_hdr_id = trn_wh_issue_hdrs.id')
                              .where('trn_wh_issue_dtls.rfid_tag=? and trn_wh_issue_dtls.status=?',rfid_tag,'loaded').first
        if mat_desc.blank?
          render json: {status:"error", "message": "No Matches Found for this Rfid"}, status: :internal_server_error 
        else
          render json:mat_desc
        end 
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end
  
  def fetch_stock_transfers
	  begin
  		user_plant = params['user_plant']
  		doc_no = TrnWhRequestDtl.select('distinct sto_ref').where('to_plant=? and sap_status=?',user_plant,'S')
		    if doc_no.blank?
          render json: {status:"error", "message": "No Stock Trasnfers Available"}, status: :internal_server_error 
        else
          render json:doc_no
        end 
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end
		

  def fetch_docno
    begin
      source_plant = params['source_plant']
      source_str_loc = params['source_str_loc']
      requested_date = Date.yesterday
      document_no = TrnWhRequestDtl.select('distinct prq_docno').where('source_plant=? and source_str_loc=? and req_dt >=?',source_plant,source_str_loc,requested_date)
        if document_no.blank?
          render json: {status:"error", "message": "No Datas Found"}, status: :internal_server_error 
        else
          render json:document_no
        end 
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def fetch_request_list
    begin
      material = []
      prq_docno = params['prq_docno']
      records = TrnWhRequestDtl.select('distinct trn_wh_request_dtls.id,trn_wh_request_dtls.mat_desc,trn_wh_request_dtls.source_plant,trn_wh_request_dtls.source_str_loc,trn_wh_request_dtls.mat_code,trn_wh_request_dtls.assigned_qty,
                                trn_wh_request_dtls.mat_uom,trn_wh_request_dtls.mat_group,trn_wh_request_dtls.tran_type,trn_wh_request_dtls.required_qty,trn_wh_request_dtls.req_dt, trn_mat_requisition_hdrs.req_no,trn_wh_request_dtls.to_plant,
                                trn_wh_request_dtls.to_str_loc,trn_mat_requisition_hdrs.vendor_code')
                               .joins('inner join trn_mat_requisition_hdrs on trn_mat_requisition_hdrs.req_no = trn_wh_request_dtls.req_no 
                                ')
                               .where('trn_wh_request_dtls.prq_docno=? ',prq_docno)
        
        records.each_with_index do |r,i|
        
          issued_qty = TrnWhRequestDtlItem.select('loaded_qty').where('prq_docno=? and mat_code=?',prq_docno,r.mat_code)        
          issued_qty.each_with_index do |s,i|  
        if s 
          balance_qty = (r.assigned_qty - s.loaded_qty)
          r.assigned_qty = balance_qty
        else
          end  
        end 

        if !r.vendor_code == ''
          @batch = WhMaterialStorage.select('vendor_batch,vendor_code,sap_batch,wh_loc_id,wh_balance_qty').where('mat_code=? and vendor_code=? and plant=? and str_loc=? and wh_balance_qty > 0',r.mat_code,r.vendor_code,r.source_plant,r.source_str_loc)
        else
          @batch = WhMaterialStorage.select('vendor_batch,sap_batch,wh_loc_id,wh_balance_qty').where('mat_code=? and plant=? and str_loc=?  and wh_balance_qty > 0',r.mat_code,r.source_plant,r.source_str_loc)
        end
          batch = {}
          batch.store(:materials,r)   
          batch.store(:sap_batch,@batch)
          material << batch
        end 
      if records.blank?
        render json: {status:"error", "message": "No Matches Found for this document number"}, status: :internal_server_error 
      else
        render json:material
      end 
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

   def fetch_request_material
    begin
      material = []
      prq_docno = params['prq_docno']
      records = TrnWhRequestDtl.select('distinct trn_wh_request_dtls.id,trn_wh_request_dtls.mat_desc,trn_wh_request_dtls.source_plant,trn_wh_request_dtls.source_str_loc,trn_wh_request_dtls.mat_code,trn_wh_request_dtls.assigned_qty,
                                trn_wh_request_dtls.mat_uom,trn_wh_request_dtls.mat_group,trn_wh_request_dtls.tran_type,trn_wh_request_dtls.required_qty,trn_wh_request_dtls.req_dt, trn_mat_requisition_hdrs.req_no,trn_wh_request_dtls.to_plant,
                                trn_wh_request_dtls.to_str_loc,trn_mat_requisition_hdrs.vendor_code')
                               .joins('inner join trn_mat_requisition_hdrs on trn_mat_requisition_hdrs.req_no = trn_wh_request_dtls.req_no 
                                ')
                               .where('trn_wh_request_dtls.prq_docno=? ',prq_docno)
        
        records.each_with_index do |r,i|
        
          issued_qty = TrnWhRequestDtlItem.select('loaded_qty').where('prq_docno=? and mat_code=?',prq_docno,r.mat_code)        
          issued_qty.each_with_index do |s,i|  
        if s 
          balance_qty = (r.assigned_qty - s.loaded_qty)
          r.assigned_qty = balance_qty
        else
          end  
        end 

        if !r.vendor_code == ''
          @batch = TrnWipStock.all.where('mat_code=? and vendor_code=? and plant=? and str_loc=? and bal_qty > 0',r.mat_code,r.vendor_code,r.source_plant,r.source_str_loc).order('expiry_dt asc')
        else
          @batch = TrnWipStock.all.where('mat_code=? and plant=? and str_loc=?  and bal_qty > 0',r.mat_code,r.source_plant,r.source_str_loc).order('expiry_dt asc')
        end
          batch = {}
          batch.store(:materials,r)   
          batch.store(:sap_batch,@batch)
          material << batch
        end 
      if records.blank?
        render json: {status:"error", "message": "No Matches Found for this document number"}, status: :internal_server_error 
      else
        render json:material
      end 
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trn_wh_request_dtl
      @trn_wh_request_dtl = TrnWhRequestDtl.find(params[:id])
    end
	


    # Never trust parameters from the scary internet, only allow the white list through.
    def trn_wh_request_dtl_params
      params.require(:trn_wh_request_dtl).permit(:prq_docno,:deliever_dt,:delievery_dt,:source_plant,:source_str_loc,:to_plant,:to_str_loc,:req_no,:req_dt,:mat_group,:mat_desc,:mat_code,:mat_uom,:required_qty,:assigned_qty,:loaded_qty,:issue_batch,:issue_batch_qty,:tran_type,:sto_ref,:sto_ref_pdf_path,:sap_status,:sap_err_msg,:sap_upd_dttime,:user_id,:action_status)
    end
end
