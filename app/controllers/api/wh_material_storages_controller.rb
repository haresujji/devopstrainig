class Api::WhMaterialStoragesController < Api::ApiController
  before_action :authenticate_user
  before_action :set_wh_material_storage, only: [:show, :edit, :update, :destroy,:update_storage]
  require 'mail'

  # GET /wh_material_storages/new
  def new
    @wh_material_storage = WhMaterialStorage.new
  end

  # POST /wh_material_storages
  # POST /wh_material_storages.json
  def create
    begin
      @wh_material_storage = WhMaterialStorage.new(wh_material_storage_params)
      @wh_material_storage.action_status =  params[:event] == 'submit' ? 'closed' : 'active'
        if @wh_material_storage.save
          render json: @wh_material_storage, status: :created
        else
          render json: {status: "error", message: @wh_material_storage.errors.full_messages.first}, status: :unprocessable_entity 
        end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  # PATCH/PUT /wh_material_storages/1
  # PATCH/PUT /wh_material_storages/1.json
  def update
    begin
      status =  params[:event] == "submit" ? 'closed' : 'active'
      params = wh_material_storage_params
      params[:action_status] = status
      @wh_material_storage.update(wh_balance_qty: params[:wh_loc_qty],wh_picked_qty: 0)
      if @wh_material_storage.update(params)
        render json: @wh_material_storage, status: :ok
      else
        render json: {status: "error", message: @wh_material_storage.errors.full_messages.first}, status: :unprocessable_entity 
      end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def update_storage
    begin
      status = params[:event] == "submit" ? 'closed' : 'active'
      params = wh_material_storage_params
      params[:action_status] = status
      wh_loc_rfid =  params[:wh_loc_rfid]
      wh_material_storage = WhMaterialStorage.find_by(wh_loc_rfid:wh_loc_rfid)
      @wh_material_storage.update(wh_balance_qty: params[:wh_loc_qty],wh_picked_qty: 0)
      if wh_material_storage.blank?
        @wh_material_storage.update(params)
        render json:@wh_material_storage
      else
        render json: {status:"error", "message": 'Location Rfid already exists'}, status: :internal_server_error 
      end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def fetch_rfid_loc_details
    begin
      wh_loc_rfid = params['wh_loc_rfid']
      records = WhMaterialStorage.select('id,vendor_batch,wh_loc_id,wh_loc_qty,wh_balance_qty,mat_code,mat_desc,mat_uom,mat_group,sap_batch,expiry_dt')
                                 .where('wh_loc_rfid=?',wh_loc_rfid)
                                 .where('plant=?','1800')
                                 .where('action_status=?','active').first    
        if records.blank?
          render json: {status:"error", "message": "No Matches Found for this RFID"}, status: :internal_server_error 
        else
          render json:records
        end 
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def check_fefo
  	begin 
  		mat_code = params['mat_code']
  		expiry_dt = params['expiry_dt']
  		records = WhMaterialStorage.select('id').where('mat_code=? and expiry_dt < ? and stock_status=?',mat_code,expiry_dt,'UR') 		
  		if records.blank?
  			render json: {status:"success","message": "Success"},status: :ok
  		else
  			render json:{status:"Error","message": "FEFO VIOLATION"}, status: :internal_server_error
  		end
  	rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error
    end
  end

  def transfer_rfid_details
    begin
      wh_source_location = params['wh_source_location']
      wh_destination_location = params['wh_destination_location']
      wh_sap_batch = params['wh_sap_batch']
      wh_mat_code = params['wh_mat_code']
      records = WhMaterialStorage.select('id,vendor_batch,wh_loc_id,wh_loc_qty,wh_balance_qty,mat_code,mat_desc,mat_uom,mat_group,sap_batch,expiry_dt')
                                 .where('wh_loc_id=?',wh_destination_location)
                                 .where('sap_batch=?',wh_sap_batch).where('mat_code=?',wh_mat_code).where('plant=?','1800')
      if records.blank?
        WhMaterialStorage.find_by_sql(["update wh_material_storages set wh_loc_id=? where sap_batch=? and mat_code=?",wh_destination_location,wh_sap_batch,wh_mat_code])
        render json: {status:"success", "message": "Destination has been allocated Sucessfully"}, status: :ok 
      else       
        render json: {status:"error", "message": "Destination already has same Material"}, status: :internal_server_error 
      end     
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error
    end
  end


  def fetch_details_for_location
    begin
      wh_loc_id = params[:wh_loc_id]
      records = WhMaterialStorage.select('id,mat_desc,vendor_batch,wh_loc_id').order('expiry_dt asc')
                                 .where('wh_loc_id=?',wh_loc_id)
        if records.blank?
          render json: {status:"error", "message": "No Matches Found for this location"}, status: :internal_server_error 
        else
          render json:records
        end 
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def fetch_material
    begin
      records = WhMaterialStorage.where('wh_loc_rfid is null and wh_loc_id!=? and plant=?','','1800').order('expiry_dt asc')
        if records.blank?
          render json: {status:"error", "message": "No Datas Found"}, status: :internal_server_error 
        else
          render json:records
        end 
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def fetch_location_id
    begin
      mat_desc = params[:mat_desc]
      location_ids = WhMaterialStorage.select('id,mat_desc,wh_loc_id,vendor_batch,wh_loc_qty,wh_balance_qty,wh_picked_qty,expiry_dt')
                                      .where('mat_desc=?',mat_desc).order('expiry_dt asc')
        if location_ids.blank?
          render json: {status:"error", "message": "No Matches Found for this material description"}, status: :internal_server_error 
        else
          render json:location_ids
        end 
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end


  def fetch_material_items
    begin
      material_items = MatUserHdr.all.where('user_id=?',1).first
        if material_items.blank?
          render json: {status:"error", "message": "No Datas Found"}, status: :internal_server_error 
        else
          render json:material_items
        end 
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def fetch_list
    begin
      mat_code = params['mat_code']
      records = TrnWipStock.where('mat_code=? and bal_qty > 0',mat_code).order('plant,expiry_dt asc')
        if records.blank?
          render json: {status:"error", "message": "No Material Found for this material code"}, status: :internal_server_error 
        else
          render json:records
        end 
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end


  def fetch_materials
    begin
      plant = params['plant']
      str_loc = params['str_loc']
      records = WhMaterialStorage.select('distinct vendor_batch,wh_loc_qty,wh_balance_qty,mat_code,mat_desc,mat_uom,mat_group,sap_batch,expiry_dt')
                                 .where('plant=? and str_loc=? and stock_status=? and wh_balance_qty > 0',plant,str_loc,'UR').order('expiry_dt asc')
        if records.blank?
          render json: {status:"error", "message": "No Matches Found for this plant and location"}, status: :internal_server_error 
        else
          render json:records
        end 
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def fetch_sap_qty
    begin
      vendor_batch = params['vendor_batch']
      sap_batch = params['sap_batch']
      mat_code = params['mat_code']
      source_plant = params['source_plant']
      source_str_loc = params['source_str_loc']
      records = WhMaterialStorage.select('wh_loc_qty,wh_balance_qty,mat_desc,plant,str_loc,mat_code,sap_batch')
                                 .where('vendor_batch=? and mat_code=? and plant=? and str_loc=? and sap_batch=? and stock_status=? and wh_balance_qty >?',vendor_batch,mat_code,source_plant,source_str_loc,sap_batch,'UR',0)
                                 .order('expiry_dt asc').first
        if records.blank?
          render json: {status:"error", "message": "Location does not contain sufficient Quantity"}, status: :internal_server_error 
        else
          render json:records
        end 
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end


  def fetch_mail
    records = params['fefo']
    plant = records['plant']
    str_loc = records['str_loc']
    date = records['date']
    reason = records['reason']
    expiry_dt = records['expiry_dt']
    sap_batch = records['sap_batch']
      if records
       UserMailer.fefo_mail(plant,str_loc,date,reason,sap_batch,expiry_dt).deliver_now
       render json: { "message": "Email send successfully."}, status: :ok
      end
  end

  def fetch_stock_qty
    begin
      plant = params['plant']
      mat_code = params['mat_code']
      stocks = WhMaterialStorage.where("mat_code=?",mat_code)
                                .where("plant in ('1801',?)",plant)
                                .order('expiry_dt asc')
        if stocks.blank?
          render json: {status:"error", "message": "No Quantity available"}, status: :internal_server_error 
        else
          render json:stocks
        end 
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end
  
  def fetch_grn_Details
    begin
      plant = params['plant']
      str_loc = params['str_loc']
	  type = params['type']
      stocks = WhMaterialStorage.all.where("plant=? and str_loc=? and wh_balance_qty > 0 and status = ?",plant,str_loc,type)
        if stocks.blank?
          render json: {status:"error", "message": "No Quantity available"}, status: :internal_server_error 
        else
          render json:stocks
        end 
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end
  
  def fetch_vendor_details
    begin
      plant = params['plant']
      str_loc = params['str_loc']
	  type = params['type']
      stocks = WhMaterialStorage.select("distinct grn_no,grn_date,mat_desc,mat_code").where("plant=? and str_loc=? and wh_balance_qty > 0 and status = ?",plant,str_loc,type)
        if stocks.blank?
          render json: {status:"error", "message": "No Quantity available"}, status: :internal_server_error 
        else
          render json:stocks
        end 
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end
  
  def fetch_grn_sup_details
    begin
      
      grn_no = params['grn_no']
	  
      stocks = WhMaterialStorage.all.where("grn_no=?",grn_no)
        if stocks.blank?
          render json: {status:"error", "message": "No Quantity available"}, status: :internal_server_error 
        else
          render json:stocks
        end 
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end
  
  



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wh_material_storage
      @wh_material_storage = WhMaterialStorage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wh_material_storage_params
      params.require(:wh_material_storage).permit(:ge_doc_no,:plant,:str_loc,:mat_group,:mat_code, :mat_desc, :mat_uom,:grn_no, :grn_qty, :grn_date, 
        :vendor_batch,:mfg_date, :expiry_dt, :wh_loc_id, :wh_loc_rfid, :wh_loc_qty, :wh_picked_qty,   :wh_balance_qty, :wh_hold_reason, :sup_roll_ref,:vendor_code,:vendor_name, :sap_batch, :sap_status,:stock_status, :status,:action_status)
    end
end
