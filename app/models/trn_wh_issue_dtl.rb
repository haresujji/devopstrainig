class TrnWhIssueDtl < ApplicationRecord
	belongs_to :trn_wh_issue_hdr
	after_create :reduce_stock 

  def reduce_stock
    if self.tran_type == 'issue'
      puts "---------if--------"
      wh_material_storage = WhMaterialStorage.where("wh_loc_id=? and sap_batch=? and plant=? and sup_roll_ref=? and mat_code=?",self.wh_loc_id,self.sap_batch,self.source_plant,self.sup_roll_ref,self.mat_code)
      puts wh_material_storage.to_json
        wh_material_storage.each do |w|
          picked_quantity =  w.wh_picked_qty.to_f + self.issued_qty.to_f
          balance_quantity = w.wh_loc_qty.to_f - picked_quantity.to_f
            if wh_material_storage
              wh_material_storage.update(wh_picked_qty:picked_quantity,wh_balance_qty:balance_quantity)
            end
        end
    end
  end
end
