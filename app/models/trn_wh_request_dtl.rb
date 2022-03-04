class TrnWhRequestDtl < ApplicationRecord

    def reduce_stock
        if self.tran_type == 'WH-ORDER-WH'
            wh_material_storage = WhMaterialStorage.where("sap_batch=? and plant=? and mat_desc=? and mat_code=?",self.issue_batch,self.source_plant,self.mat_desc,self.mat_code)
            wh_material_storage.each do |w|
                picked_quantity =  w.wh_picked_qty + self.loaded_qty.to_f
                balance_quantity = w.wh_loc_qty - picked_quantity
                    if wh_material_storage
                        wh_material_storage.update(wh_picked_qty:picked_quantity,wh_balance_qty:balance_quantity)
                    end
            end
        end
    end
end
