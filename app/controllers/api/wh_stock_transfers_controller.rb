class Api::WhStockTransfersController < Api::ApiController
  before_action :authenticate_user


  def fetch_document_no
	  begin
	  user_plant = params['user_plant']
		user_location = params['str_loc']
    document_nos = WhStockTransfer.select('distinct wh_stock_transfers.document_no,wh_stock_transfers.truck_no,wh_stock_transfers.po_number,trn_wh_request_dtl_items.prq_docno,
                                    wh_stock_transfers.trans_type,wh_stock_transfers.received_qty,wh_stock_transfers.mat_code,wh_stock_transfers.mat_uom,
                                    wh_stock_transfers.mat_desc,wh_stock_transfers.gross_weight,wh_stock_transfers.tare_weight,wh_stock_transfers.net_weight,
                                    wh_stock_transfers.from_plant,wh_stock_transfers.sto_dt,wh_stock_transfers.from_str_loc,wh_stock_transfers.sap_batch,wh_stock_transfers.to_plant,wh_stock_transfers.to_str_loc')
					                          .joins('INNER JOIN trn_wh_request_dtl_items on wh_stock_transfers.po_number = trn_wh_request_dtl_items.sto_ref')
                                    .where('trn_wh_request_dtl_items.to_plant=? and trn_wh_request_dtl_items.to_str_loc=?',user_plant,user_location)	
      if document_nos.blank?
        render json: {status:"error", "message": "No records Found "}, status: :internal_server_error 
      else
        render json:document_nos
      end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def fetch_sup_roll_ref
    begin
      document_no = params['document_no']
      mat_code = params['mat_code']   
      records = WhStockTransfer.select('distinct sup_roll_ref').where('document_no=? and mat_code=?',document_no,mat_code)
        if records.blank?
          render json: {status:"error", "message": "No records Found for this document no"}, status: :internal_server_error 
        else
          render json:records
        end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def fetch_list
	  begin
  	  document_no = params['document_no']
  	  records = WhStockTransfer.select('distinct wh_stock_transfers.mat_code,wh_stock_transfers.document_no,wh_stock_transfers.truck_no,wh_stock_transfers.po_number,wh_stock_transfers.trans_type,wh_stock_transfers.received_qty,wh_stock_transfers.mat_uom,wh_stock_transfers.mat_desc,wh_stock_transfers.gross_weight,
                               wh_stock_transfers.tare_weight,wh_stock_transfers.net_weight,wh_stock_transfers.from_plant,wh_stock_transfers.sto_dt,wh_stock_transfers.from_str_loc,wh_stock_transfers.sap_batch,trn_wh_request_dtl_items.mat_group')
                               .joins('inner join trn_wh_request_dtl_items on trn_wh_request_dtl_items.sto_ref = wh_stock_transfers.po_number')
                               .where('wh_stock_transfers.document_no=?',document_no)
	      if records.blank?
          render json: {status:"error", "message": "No records Found for this document no"}, status: :internal_server_error 
        else
          render json:records
        end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def fetch_description
    begin
      records = WhStockTransfer.select('distinct id, mat_desc,mat_code')
        if records.blank?
          render json: {status:"error", "message": "No records Found"}, status: :internal_server_error 
        else
          render json:records
        end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end
end