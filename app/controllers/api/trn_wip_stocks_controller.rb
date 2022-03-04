class Api::TrnWipStocksController < Api::ApiController
   before_action :authenticate_user


 def index
    begin
      plant = params['plant']
      str_loc = params['str_loc']
      requested_date = Date.yesterday
      @trn_wip_stocks = TrnWipStock.all
                                   .where('plant=? and str_loc=?',plant,str_loc)
                                   .where('rfid_tag is null').where('status !=? and bal_qty > 0','G')
        if @trn_wip_stocks.blank?
          render json: {status:"error", "message": "No Matches Found for this plant and location"}, status: :internal_server_error 
        else
          render json:@trn_wip_stocks
        end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end



    def fetch_vendor_batches
        
        begin
    
      records = TrnWipStock.all
                           .where('plant=? and str_loc=?','1801','RM08')
                           .where("LENGTH (vendor_batch) > ?",1)
        if records.blank?
          render json: {status:"error", "message": "No Matches Found for this plant and location"}, status: :internal_server_error 
        else
          render json:records
        end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end 
        
        
    end



 def fetch_sap_batch
    begin
      plant = params['plant']
      str_loc = params['str_loc']
      mat_code = params['mat_code']
      records = TrnWipStock.select('sap_batch,bal_qty as balance_qty').where('plant=? and str_loc=? and mat_code=? and bal_qty > 0',plant,str_loc,mat_code)
        if records.blank?
          render json: {status:"error", "message": "No Matches Found for this plant and location"}, status: :internal_server_error 
        else
          render json:records
        end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end
  
    def fetch_workcenter
    begin
      plant = params["plant"]
      str_loc = params['str_loc']
      records = TrnWipStock.select('distinct work_center').where('work_center is not null')
                           .where('plant=? and str_loc=?',plant,str_loc)
                            .where("rfid_tag is null or rfid_tag=?",'')
        if records.blank?
          render json: {status:"error", "message": "No Matches Found for this plant and location"}, status: :internal_server_error 
        else
          render json:records
        end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end
  
  def fetch_work_center_list
    begin
      work_center = params["work_center"]
      records = TrnWipStock.select('id,mat_code as sfg_code,sap_batch,mat_desc as sfg_desc,comp_lotno as lot_no,mat_qty as stock_qty_kg,batch_reference,bal_qty as balance_qty,vendor_name,expiry_dt')
                           .where("work_center=?",work_center)
                           .where("vendor_batch is null or vendor_batch=?",'')
        if records.blank?
          render json: {status:"error", "message": "No Matches Found for this plant and location"}, status: :internal_server_error 
        else
          render json:records
        end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end
  
  def update_rfid
    begin
      event = params[:event]
      quantity = params[:quantity]
      id = params[:id]
      params = trn_wip_stock_params
      trn_wip_stock = TrnWipStock.find_by(vendor_batch:params[:vendor_batch])
      
        if event == 'Full'
          @trn_wip_stock.update(params)
          @trn_wip_stock.update(pallet_rfid_date: Time.now,issue_status:'G')
        end
        update_wip(event,quantity,params[:sap_batch],params[:mat_code],params[:plant],params[:rfid_tag],params[:vendor_batch],id)
       
     
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

def update_wip(ob_type,quantity,sap_batch,mat_code,plant,rfid_tag,batch_reference,id)
    if ob_type == 'Partial'
      puts "if"
      wip = TrnWipStock.find_by(sap_batch:sap_batch,mat_code:mat_code,id:id)
      puts wip.to_json
       if !wip.blank?
        puts "ifff"
         cons_qty = wip.cons_qty.to_i + quantity.to_i
         bal_qty = wip.received_qty.to_i - cons_qty.to_i
         wip.update(cons_qty:cons_qty,bal_qty:bal_qty)
         puts "after update"
         TrnWipStock.create!(plant:wip.plant,work_center:wip.work_center,batch_reference:batch_reference,comp_rfid_date:wip.comp_rfid_date,str_loc:wip.str_loc,mat_group:wip.mat_group,mat_code:wip.mat_code,mat_desc:wip.mat_desc,mat_uom:wip.mat_uom,mat_qty:wip.mat_qty,received_qty:quantity,cons_qty:0,bal_qty:quantity,comp_lotno:wip.comp_lotno,sap_batch:wip.sap_batch,expiry_dt:wip.expiry_dt,rfid_status:'open',action_status:'open',vendor_name:wip.vendor_name,vendor_code:wip.vendor_code,vendor_batch:batch_reference,comp_batchno:wip.comp_batchno,rfid_tag:rfid_tag,mat_group_name:wip.mat_group_name,issue_status:'G')
         puts "afetre create"
         render json: wip, status: :ok
       end
    end
  end
  
    def fetch_stock_qty
    begin
      plant = params['plant']
      mat_code = params['mat_code']
      stocks = TrnWipStock.where("mat_code=? and bal_qty > 0",mat_code).order('expiry_dt asc')
        if stocks.blank?
          render json: {status:"error", "message": "No Quantity available"}, status: :internal_server_error 
        else
          render json:stocks
        end 
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end
  
  
  def fetch_material_barcode
    begin
      mat_code = params['mat_code']
      vendor_batch = params['vendor_batch']
      stocks = TrnWipStock.all.where("mat_code=? and vendor_batch = ? and bal_qty > 0",mat_code,vendor_batch).first
        if stocks.blank?
          render json: {status:"error", "message": "No Material available"}, status: :internal_server_error 
        else
          render json:stocks
        end 
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end  
    
end

     def fetch_reprint_barcode
    begin
      mat_code = params['mat_code']
      vendor_batch = params['vendor_batch']
      stocks = TrnWipStock.all.where("vendor_batch != ? and bal_qty > 0",'')
        if stocks.blank?
          render json: {status:"error", "message": "No Material available"}, status: :internal_server_error 
        else
          render json:stocks
        end 
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end  
    
end
      
    
  
    def set_trn_wip_stock
      @trn_wip_stock = TrnWipStock.find(params[:id])
    end
    



 def trn_wip_stock_params
       params.require(:trn_wip_stock).permit(:plant,:event,:master_id,:batch_reference,:comp_rfid_date,:trt_code,:net_wt,:plan_order_no,:str_loc,:mat_group, :mat_code,:mat_desc,:mat_uom,:mat_qty,:received_qty,:cons_qty, :bal_qty, :comp_lotno,:sap_batch,:expiry_dt,:rfid_status,:action_status, :load_dttime,:rm_gross_wt,  :tare_wt,  :rm_empty_shell_wt, :rm_net_wt, :vendor_batch, :unload_type,:user_id,:req_no,:comp_batchno,:rfid_tag,:mat_group_name,:station,:work_center,:gross_wt,:comp_status)
    end


end