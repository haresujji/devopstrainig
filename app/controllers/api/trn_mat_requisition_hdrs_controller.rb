class Api::TrnMatRequisitionHdrsController < Api::ApiController
  before_action :authenticate_user
  before_action :set_trn_mat_requisition_hdr, only: [:show, :edit, :update, :destroy]

  # GET /trn_mat_requisition_hdrs/new
  def new
    @trn_mat_requisition_hdr = TrnMatRequisitionHdr.new
  end

  # POST /trn_mat_requisition_hdrs
  # POST /trn_mat_requisition_hdrs.json
  def create
    begin
      @trn_mat_requisition_hdr = TrnMatRequisitionHdr.new(trn_mat_requisition_hdr_params)
      @trn_mat_requisition_hdr.action_status =  params[:event] == 'submit' ? 'closed' : 'active'
      if @trn_mat_requisition_hdr.save
        render json: @trn_mat_requisition_hdr.to_json(:include => {
        :trn_mat_requisition_items => {as: :trn_mat_requisition_items_attributes}
        }), status: :created
        else
          render json: {status: "error", message: @trn_mat_requisition_hdr.errors.full_messages.first}, status: :unprocessable_entity 
        end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  # PATCH/PUT /trn_mat_requisition_hdrs/1
  # PATCH/PUT /trn_mat_requisition_hdrs/1.json
  def update
    begin
      status = params[:event] == "submit" ? 'closed' : 'active'
      params = trn_mat_requisition_hdr_param
      params[:action_status] = status
      if @trn_mat_requisition_hdr.update(params)
        render json: @trn_mat_requisition_hdr, status: :ok
      else
        render json: {status: "error", message: @trn_mat_requisition_hdr.errors.full_messages.first}, status: :unprocessable_entity 
      end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  # DELETE /trn_mat_requisition_hdrs/1
  # DELETE /trn_mat_requisition_hdrs/1.json
  def cancel_request
    begin
      req_no = params['req_no']
      @trn_mat_requisition_hdr = TrnMatRequisitionHdr.find_by(req_no:req_no)
      @trn_mat_requisition_hdr.update(action_status:'delete')
      render status: :ok, json: {response: 'Deleted'}
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end


  def requisition_hdrs_period_filter
    begin
      from = params['from']
      to = params['to']
      plant = params['plant']
      material_req = []
      records = TrnMatRequisitionHdr.select('trn_mat_requisition_hdrs.*')
                                          .where('trn_mat_requisition_hdrs.plant=?',plant)
                                          .where("to_char(trn_mat_requisition_hdrs.req_dt,'yyyy-mm-dd')   between  ? AND ?",from,to)
        records.each_with_index do |r,i|
          @request_dtl = TrnMatRequisitionItem.select('trn_mat_requisition_items.*,trn_wh_issue_dtls.issued_qty,trn_mat_requisition_hdrs.req_no as req_number')
                                              .joins('inner join trn_mat_requisition_hdrs on trn_mat_requisition_hdrs.id = trn_mat_requisition_items.trn_mat_requisition_hdr_id
                                               left join  trn_wh_issue_hdrs on trn_wh_issue_hdrs.req_no = trn_mat_requisition_hdrs.req_no
                                               left join trn_wh_issue_dtls on trn_wh_issue_dtls.trn_wh_issue_hdr_id = trn_wh_issue_hdrs.id and trn_wh_issue_dtls.mat_code = trn_wh_issue_hdrs.mat_code ')
                                              .where('trn_mat_requisition_hdr_id=?',r.id)
          list = {}
          list.store(:hdrs,r)   
          list.store(:dtls,@request_dtl)
          material_req << list
        end 
      if records.blank?
        render json: {status:"error", "message": "No Matches Found for this document number"}, status: :internal_server_error 
      else
        render json:material_req
      end 
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end


  def requisition_period_filter
    begin
      from = params['from']
      to = params['to']
      plant = params['plant']
      str_loc = params['str_loc']
      material_req = []
      records = TrnMatRequisitionHdr.select('trn_mat_requisition_hdrs.*')
                                     .joins('inner join trn_mat_requisition_items on trn_mat_requisition_hdrs.id = trn_mat_requisition_items.trn_mat_requisition_hdr_id')
                                     .where('trn_mat_requisition_items.str_plant=? and trn_mat_requisition_items.str_loc=?',plant,str_loc)
                                     .where("to_char(trn_mat_requisition_hdrs.req_dt,'yyyy-mm-dd')   between  ? AND ?",from,to)
        records.each_with_index do |r,i|
          @request_dtl = TrnMatRequisitionItem.select('trn_mat_requisition_items.*,trn_wh_issue_dtls.issued_qty,trn_mat_requisition_hdrs.req_no as req_number')
                                              .joins('inner join trn_mat_requisition_hdrs on trn_mat_requisition_hdrs.id = trn_mat_requisition_items.trn_mat_requisition_hdr_id
                                               left join  trn_wh_issue_hdrs on trn_wh_issue_hdrs.req_no = trn_mat_requisition_hdrs.req_no
                                               left join trn_wh_issue_dtls on trn_wh_issue_dtls.trn_wh_issue_hdr_id = trn_wh_issue_hdrs.id and trn_wh_issue_dtls.mat_code = trn_wh_issue_hdrs.mat_code ')
                                              .where('trn_mat_requisition_hdr_id=?',r.id)
          list = {}
          list.store(:hdrs,r)   
          list.store(:dtls,@request_dtl)
          material_req << list
        end 
      if records.blank?
        render json: {status:"error", "message": "No Matches Found for this document number"}, status: :internal_server_error 
      else
        render json:material_req
      end 
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def update_mat_qty
    req_no = params['req_no']
    mat_qty = params['mat_qty']
    mat_code = params['mat_code']
    mat_request = TrnMatRequisitionHdr.find_by(req_no:req_no)
    mat_request_dtl = TrnMatRequisitionItem.find_by(mat_code: mat_code,trn_mat_requisition_hdr_id:mat_request.id)
      if mat_request_dtl
        mat_request_dtl.update(mat_qty:mat_qty)
        render json: mat_request_dtl
      end
  end


  def fetch_plants
    begin
      plant_lists = TrnMatRequisitionHdr.select('distinct plant').where('action_status!=? and plant is not null','')
        if plant_lists.blank?
          render json: {status:"error", "message": "No datas Found"}, status: :internal_server_error 
        else
          render json:plant_lists
        end   
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end                   
  end

  def fetch_location
    begin
      plant = params['plant']
      location_lists = TrnMatRequisitionHdr.select('distinct str_loc,plant')
                                            .where('plant=?',plant)
        if location_lists.blank?
          render json: {status:"error", "message": "No Matches Found for this Plant"}, status: :internal_server_error 
        else
          render json:location_lists
        end  
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end                   
  end

  def fetch_material_list
    begin
      location = params['location']
      material_lists = TrnMatRequisitionHdr.select('trn_mat_requisition_hdrs.req_no,trn_mat_requisition_hdrs.vendor_code,trn_mat_requisition_hdrs.req_dt,trn_mat_requisition_items.status,
                                            trn_mat_requisition_items.mat_desc,trn_mat_requisition_items.mat_qty,trn_mat_requisition_items.mat_code,trn_mat_requisition_items.mat_uom,trn_mat_requisition_items.mat_group')
                                           .joins(:trn_mat_requisition_items).where('trn_mat_requisition_hdrs.str_loc=? and trn_mat_requisition_items.status=?',location,'closed')
                                           .order('trn_mat_requisition_hdrs.created_at,trn_mat_requisition_items.priority asc')
        if material_lists.blank?
          render json: {status:"error", "message": "No Matches Found for this Location"}, status: :internal_server_error 
        else
          render json:material_lists
        end 
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end                   
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trn_mat_requisition_hdr
      @trn_mat_requisition_hdr = TrnMatRequisitionHdr.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trn_mat_requisition_hdr_params
      trn_mat_requisition_hdr_params = params.require(:trn_mat_requisition_hdr).except(:id,:trn_mat_requisition_hdr_id)
                                    .permit(:plant, :str_loc, :req_no, :req_dt,  :vendor_code, :user_id, :action_status, { trn_mat_requisition_items_attributes: [:req_no, :mat_code, :mat_desc,:mat_group,:str_loc, :mat_uom, :mat_qty,:priority,:str_plant,:status]})
    end
    
    def trn_mat_requisition_hdr_param
      trn_mat_requisition_hdr_params = params.require(:trn_mat_requisition_hdr)
                                    .permit(:plant, :str_loc, :req_no, :req_dt,  :vendor_code, :user_id, :action_status, { trn_mat_requisition_items_attributes: [:id,:trn_mat_requisition_hdr_id,:req_no, :mat_code, :mat_desc,:mat_group,:str_loc, :mat_uom, :mat_qty,:priority,:str_plant,:status]})
    end
end
