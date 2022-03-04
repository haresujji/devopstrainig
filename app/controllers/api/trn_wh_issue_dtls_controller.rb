class Api::TrnWhIssueDtlsController < Api::ApiController
   before_action :authenticate_user
  before_action :set_trn_wh_issue_dtl, only: [:show, :edit, :update, :destroy,:get]
  
  def update_security_process
    begin
      issue_docno = params['issue_docno']
      rfid_tag = params['rfid_tag']
      mat_desc = TrnWhIssueDtl.where('issue_docno=? and rfid_tag=? and status=?',issue_docno,rfid_tag,'loaded').update(status:'GE')
        if mat_desc.blank?
          render json: {status:"error", "message": "No Matches Found for this Rfid"}, status: :internal_server_error 
        else
          mat_desc = TrnWhIssueHdr.select('trn_wh_issue_hdrs.plant,trn_wh_issue_hdrs.issue_docdt,trn_wh_issue_hdrs.issue_docno,trn_wh_issue_hdrs.str_loc,trn_wh_issue_hdrs.to_plant,trn_wh_issue_hdrs.to_str_loc,trn_wh_issue_dtls.tran_type,trn_wh_issue_hdrs.req_no,trn_wh_issue_dtls.mat_group,trn_wh_issue_dtls.mat_code,
                               trn_wh_issue_dtls.mat_desc,trn_wh_issue_dtls.rfid_tag,trn_wh_issue_dtls.mat_uom,trn_wh_issue_dtls.issued_qty,trn_wh_issue_dtls.expiry_dt,trn_wh_issue_dtls.sup_roll_ref,trn_wh_issue_dtls.sap_batch')
                              .joins('INNER JOIN trn_wh_issue_dtls on trn_wh_issue_dtls.trn_wh_issue_hdr_id = trn_wh_issue_hdrs.id')
                              .where('trn_wh_issue_dtls.rfid_tag=? and trn_wh_issue_dtls.status=?',rfid_tag,'active').first
         
          render json:mat_desc
        end 
    rescue StandardError => e
      render json: {status:"error", "message": e.message}, status: :internal_server_error 
    end
  end
end
