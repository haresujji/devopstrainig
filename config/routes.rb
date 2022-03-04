Rails.application.routes.draw do
	namespace :api do  
    resources :wh_material_storages do
      get :fetch_material, on: :collection
      patch :update_status,on: :collection
      get :fetch_details_for_location,on: :collection
      get :fetch_location_id,on: :collection
      get :fetch_user_details,on: :collection
      get :fetch_list,on: :collection
      get :fetch_materials,on: :collection
      get :fetch_sap_qty,on: :collection
      post :fetch_mail,on: :collection
      get :fetch_rfid_loc_details,on: :collection
      get :transfer_rfid_details,on: :collection
      get :fetch_stock_qty,on: :collection
      get :check_fefo,on: :collection
      patch :update_storage,on: :collection
	  get :fetch_grn_Details,on: :collection
	  get :fetch_vendor_details,on: :collection
	  get :fetch_grn_sup_details,on: :collection
	  
	  
    end
    resources :wh_bundle_types do
      get :bundle_list,on: :collection
    end
    resources :trn_wip_stocks do
      get :fetch_sap_batch, on: :collection
       get :fetch_workcenter, on: :collection
      get :fetch_work_center_list, on: :collection
       get :fetch_stock_qty,on: :collection
       get :fetch_vendor_batches,on: :collection
       get :fetch_material_barcode,on: :collection
       get :fetch_reprint_barcode,on: :collection
       patch "update_rfid/:id", to: "trn_wip_stocks#update_rfid", on: :collection

    end
    resources :wh_sto_hdrs do 
      get :fetch_docno, on: :collection
      get :fetch_current_date_object, on: :collection
      get :fetch_hdrs, on: :collection
      get :fetch_sto_list, on: :collection
      get :fetch_stos, on: :collection
      get :fetch_docno_list, on: :collection
      patch :update_list, on: :collection
      get :fetch_trucknumber, on: :collection
      get :fetch_transport_vendor, on: :collection
      patch :update_status, on: :collection
      patch :update_completed, on: :collection
      patch :update_unload_status, on: :collection
      patch :update_truck_status, on: :collection
      patch :update_action_status, on: :collection
      patch :updatevehicle_time, on: :collection
      get :fetch_sto_dtls, on: :collection
      get :fetch_picked_warehouse, on: :collection
      get :fetch_sto_unloading, on: :collection
      patch :update_truck_transfer, on: :collection
    end
     resources :wh_sto_dtls do
       get :fetch_warehouse_dtls, on: :collection
       get :fetch_dtls, on: :collection
       patch :update_new_sapbatch, on: :collection
       get :fetch_plantlocation, on: :collection
       get :fetch_wt, on: :collection
       get :fetch_sto_print_dtls, on: :collection
     end
     resources :trn_mat_requisition_items
     resources :trn_mat_requisition_hdrs do
     	get :fetch_plants,on: :collection
      get :requisition_hdrs_period_filter,on: :collection
     	get :fetch_location,on: :collection
      get :fetch_material_list,on: :collection
      get :cancel_request,on: :collection
      patch :update_mat_qty,on: :collection
      get :requisition_period_filter,on: :collection
     end    
     resources :wh_stock_transfers do
      get :fetch_document_no,on: :collection
      get :fetch_list,on: :collection
      get :fetch_description,on: :collection
      get :fetch_sup_roll_ref,on: :collection 
     end
     resources :trn_mat_receipts do
      post :create_issue,on: :collection
      post :mat_receipts,on: :collection
      
     end
     resources :trn_wh_transport_dtls do
      get :fetch_transport_dtls,on: :collection
     end
     resources :trn_wh_issue_dtls do
	   get :update_security_process,on: :collection
	 end
    resources :trn_wh_issue_hdrs 
     resources :trt_msts
     resources :mst_vendors
     resources :trn_wh_request_dtls do		
      get :fetch_receipt,on: :collection
      get :fetch_receipt_security,on: :collection
      get :fetch_docno,on: :collection
      get :fetch_request_list,on: :collection
      get :stock,on: :collection
      get :fetch_request_material,on: :collection
	    get :fetch_stock_transfers,on: :collection
     end
     resources :trn_wh_request_dtl_items do
      get :warehouse_period_filter,on: :collection
      get :issue_hdrs_period_filter,on: :collection
      get :getStoDetails,on: :collection

     end
   end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
