class TrnWhIssueHdr < ApplicationRecord
 has_many :trn_wh_issue_dtls
 accepts_nested_attributes_for :trn_wh_issue_dtls

  before_create do
   	current_time = DateTime.now
   	current_time_month = Time.now.strftime("%Y%m%d")
   	current_count = TrnWhIssueHdr
   						  .where("issue_docno like ?", "#{current_time_month}%")
   						  .count
    number = TrnWhIssueHdr.where("issue_docno like?","#{current_time_month}%").maximum('sequence_number')
      if number 
        sequence_number = "%.5i" %(number +1)
        number = "#{number +1}"
      else
        sequence_number = "%.5i" %(current_count +1)
        number = "#{current_count +1}"
      end
 	  self.issue_docno = "#{current_time_month}#{self.str_loc}#{sequence_number}"
 	  self.issue_docdt = "#{current_time}"
   	self.sequence_number =  "#{number}" 					  	
  end


  def as_json(*)
    super.tap do |hash|
      children = self.trn_wh_issue_dtls
      hash["trn_wh_issue_dtls_attributes"] = children
    end
  end
end
