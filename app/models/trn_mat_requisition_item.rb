class TrnMatRequisitionItem < ApplicationRecord
  belongs_to :trn_mat_requisition_hdr
  before_create do
    self.status = 'closed'			  	
  end
end
