json.extract! trn_mat_requisition_hdr, :id, :plant, :str_loc, :req_no, :req_dt, :req_shift, :vendor_id, :user_id, :action_status, :created_at, :updated_at
json.url trn_mat_requisition_hdr_url(trn_mat_requisition_hdr, format: :json)
