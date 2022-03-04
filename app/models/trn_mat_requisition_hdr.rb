class TrnMatRequisitionHdr < ApplicationRecord
  validates :req_no, uniqueness: true
  has_many :trn_mat_requisition_items,dependent: :destroy
  accepts_nested_attributes_for :trn_mat_requisition_items, allow_destroy: true

  before_create do
   	current_time = DateTime.now
   	current_time_month = Time.now.strftime("%y%m")
   	current_count = TrnMatRequisitionHdr
   						  .where("req_no like ?", "#{current_time_month}%")
   						  .count
    number = TrnMatRequisitionHdr.where("req_no like?","#{current_time_month}%").maximum('sequence_number')
      if number 
        sequence_number = "%.5i" %(number +1)
        number = "#{number +1}"
      else
        sequence_number = "%.5i" %(current_count +1)
        number = "#{current_count +1}"
      end
 	  self.req_no = "#{current_time_month}#{self.str_loc}#{sequence_number}"
    self.sequence_number =  "#{number}" 				  	
  end
end
