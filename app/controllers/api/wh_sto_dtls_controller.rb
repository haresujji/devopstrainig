 class Api::WhStoDtlsController < Api::ApiController
 before_action :authenticate_user
 def create
    begin
      @wh_sto_dtl = WhStoDtl.new
       if params['reason'].blank?
        reason = ''
      else
        reason = params['reason']
      end
        count = 0
        sto_dtl_list = []
        @records = params['wh_sto_dtl'].each do |s|     
          sto_dtl = WhStoDtl.find_by(rfid_tag:s['rfid_tag'],trns_doc_no:s['trns_doc_no'])
          if !sto_dtl.blank?
            sto_dtl_list << sto_dtl
          else
            WhStoDtl.create!(trns_doc_no:s['trns_doc_no'],trns_doc_date:s['trns_doc_date'],req_dt:s['req_dt'],
                               sto_no:s['sto_no'],req_no:s['req_no'],plant:s['plant'],str_loc:s['str_loc'],
                               to_plant:s['to_plant'],source_plant:s['source_plant'],source_str_loc:s['source_str_loc'],mat_group_name:s['mat_group_name'],po_item:s['po_item'],mat_code:s['mat_code'],mat_uom:s['mat_uom'],
                               mat_desc:s['mat_desc'],mat_batch:s['mat_batch'],vbelp_st:s['vbelp_st'],charg:s['charg'],
                               lot_no:s['lot_no'],sap_batch_qty:s['sap_batch_qty'],expirty_date:s['expirty_date'],rfid_tag:s['rfid_tag'],
                               pallet_no:s['pallet_no'],trns_gross_wt:s['trns_gross_wt'],trns_tare_wt:s['trns_tare_wt'],trns_net_wt:s['trns_net_wt'],transfer_lot:s['transfer_lot'],
                               trns_transfer_dt:s['trns_transfer_dt'],trns_ack_update_dt:s['trns_ack_update_dt'],trns_err_msg:s['trns_err_msg'],sto_date:s['sto_date'],vendor_code:s['vendor_code'],
                               vendor_name:s['vendor_name'],bundle_qty:s['bundle_qty'],bundle_type:s['bundle_type'],std_wt:s['std_wt'],action_status:'closed',fefo_reason:reason)
                              count +=1
            update_value_in_wip(s['mat_batch'],s['charg'],s['trns_net_wt'])
        end
    end
      if sto_dtl_list.size == 0
        update_status_in_hdrs(@records[0]['trns_doc_no'],count)
      end
      render json:sto_dtl_list,status: 201
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def update_status_in_hdrs(trns_doc_no,count)
     hdr = WhStoHdr.find_by("trns_doc_no=?",trns_doc_no)
      if hdr
        hdr.update(action_status:'picked',no_of_bins:count)
      end
  end

    def update_value_in_wip(mat_batch,charg,trns_net_wt)
     wip = TrnWipStock.find_by("vendor_batch=? and sap_batch=?",mat_batch,charg)
      if !wip.blank?
         cons_qty = wip.cons_qty.to_i + trns_net_wt.to_i
         bal_qty = wip.received_qty.to_i - cons_qty.to_i
         wip.update(cons_qty:cons_qty,bal_qty:bal_qty,issue_status:'Y')
      end
    end

    def fetch_warehouse_dtls
    begin
      trns_doc_no = params['trns_doc_no']
      records = WhStoDtl.all.where('trns_doc_no=?',trns_doc_no)
        if records.blank?
          render json: {status:"error", "message": "No datas found for this document no"}, status: :internal_server_error 
        else
          render json:records
        end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end
  
  
  
  def fetch_sto_print_dtls
    begin
      sto_no = params['sto_no']
      records = WhStoDtl.all.where('sto_no=?',sto_no)
        if records.blank?
          render json: {status:"error", "message": "No datas found for this sto_no no"}, status: :internal_server_error 
        else
          render json:records
        end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end
  

  def fetch_dtls
    begin
    from_date = params['fromdate']
    from = from_date.to_date
    todate = params['todate']
    to = todate.to_date
    userplant = params['plant']
    userloc = params['strloc']
    offset = params['page']
    search = params["search"]
    offset_value = pagination(offset,from,to,userplant,userloc,search)
    query =  WhStoDtl.all
     if(!from_date.blank? || !todate.blank?)
     query = query.where("wh_sto_dtls.created_at  between  ? AND ?", from,to)
    end
    if userplant !='' || !userplant.blank?
     query = query.where("wh_sto_dtls.plant=?",userplant)
    end
    if userloc !='' || userloc.blank?
      query = query.where("wh_sto_dtls.str_loc=?",userloc)
    end
    if search == ''
      query = query
    end
    if !search.blank?
     query = query.   
              where('mat_desc ILIKE :search  or mat_batch ILIKE :search or mat_group_name ILIKE :search  
              or action_status ILIKE :search',{search: "%#{search}%"})                                  
    end
    @hdrs = query.where('excess_flag=? and action_status=?','Y','open').limit(5).offset(offset_value)
    fetch_page_length
    if @hdrs.blank?
      render json: {status:"error", "message": "No datas found"}, status: :internal_server_error 
    else
      render json:{osmdtllists: @hdrs, pagelength: fetch_page_length}
    end
      rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end 
  end


  def pagination(offset,from,to,userplant,userloc,search)
    per_page = 5
    count = osm_count(from,to,userplant,userloc,search)
    size = count / per_page
    page_length_calculation(count,size)
    offset_value = (offset.to_i - 1) * per_page
  end

  def osm_count(from,to,userplant,userloc,search)
    if search.blank?
     return  count = WhStoDtl.where("wh_sto_dtls.created_at  between  ? AND ?", from,to)
                     .where("wh_sto_dtls.plant=?",userplant)
                     .where("wh_sto_dtls.str_loc=?",userloc)
                     .where('excess_flag=? and action_status=?','Y','open')
                     .count
    end
    if !search.blank?
     return   count = WhStoDtl.where("wh_sto_dtls.created_at  between  ? AND ?", from,to)
                     .where("wh_sto_dtls.plant=?",userplant)
                     .where("wh_sto_dtls.str_loc=?",userloc)
                     .where('excess_flag=? and action_status=?','Y','open')
                     .where('mat_desc ILIKE :search or mat_batch ILIKE :search or mat_group_name ILIKE :search  
                      or action_status ILIKE :search',{search: "%#{search}%"})          
                     .count

    end
  end

  def page_length_calculation(records,size)
    if records % 5 != 0
      page_length = size +1
    else
      page_length = size
    end
  end

  def fetch_page_length
    begin
      from_date = params['fromdate']
      from = from_date.to_date
      todate = params['todate']
      to = todate.to_date
      userplant = params['plant']
      userloc = params['strloc']
      offset = params['page']
      search = params["search"]
      records =  osm_count(from,to,userplant,userloc,search)
      size = records / 5
      page_length = page_length_calculation(records,size)
      return page_length
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def update_new_sapbatch
    begin
    dtl_lists = params['dtls']
    dtl_lists.each do |d|
      if(d['excess_qty'].to_f > d['balanceqty'].to_f)
        return render json: 'Truck is not free', status: :created
      end
       dtl = WhStoDtl.where('sto_no_ref=? and excess_status=? and action_status=?',d['sto_no_ref'],'open','open').first
      dtl.update(charg:d['batch'],action_status:'closed',excess_status:'closed')
    end
    render json: 'ok',status: :ok
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def fetch_plantlocation
    begin
      trns_doc_no = params['trns_doc_no']
      docnos = WhStoDtl.all.where('trns_doc_no=?',trns_doc_no).first
        if docnos.blank?
          render json: {status:"error", "message": "No datas found"}, status: :internal_server_error 
        else
          render json:docnos
        end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

  def fetch_wt
    begin
      trns_doc_no = params['trns_doc_no']
      wt = WhStoDtl.select('sum(trns_gross_wt)').where('trns_doc_no=?',trns_doc_no)
      count = WhStoDtl.where('trns_doc_no=?',trns_doc_no).count
        if wt.blank? || count.blank?
          render json: {status:"error", "message": "No datas found"}, status: :internal_server_error 
        else
          render json: {total_wt: wt, rfid_list: count}, status: :ok
        end
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end

end