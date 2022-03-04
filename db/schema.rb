# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_22_072649) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "dblink"
  enable_extension "edb_dblink_libpq"
  enable_extension "edb_dblink_oci"
  enable_extension "edbspl"
  enable_extension "pldbgapi"
  enable_extension "plpgsql"

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.jsonb "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "cal_ob_vendor_batch", id: false, force: :cascade do |t|
    t.bigserial "id", null: false
    t.string "mat_code", limit: 40
    t.string "mat_desc", limit: 40
    t.string "mat_uom", limit: 2
    t.decimal "grn_qty", precision: 12, scale: 3
    t.string "vendor_code", limit: 10
    t.string "vendor_name", limit: 40
    t.string "sap_batch", limit: 10
    t.string "vendor_batch", limit: 30
    t.decimal "batch_qty", precision: 12, scale: 3
  end

  create_table "kafka_table_settings", id: false, force: :cascade do |t|
    t.serial "id", null: false
    t.string "table_key", limit: 50, default: ""
    t.datetime "kafka_updated", precision: 6, default: -> { "now()" }, null: false
    t.datetime "ftp_updated", precision: 6, default: -> { "now()" }, null: false
    t.datetime "updated_at", precision: 6, default: -> { "now()" }, null: false
    t.bigint "no_of_mts", default: 0
  end

  create_table "material_mst", primary_key: "mat_code", id: :string, limit: 40, force: :cascade do |t|
    t.serial "pk_material_id", null: false
    t.string "mat_desc", limit: 40, null: false
    t.string "mat_uom", limit: 3, null: false
    t.string "mat_type", limit: 10, null: false
    t.string "mat_group", limit: 10, null: false
    t.string "status", limit: 1, default: "0"
    t.datetime "created_datetime"
    t.datetime "modified_datetime"
  end

  create_table "mst_stock_1801rm08_temp", id: false, force: :cascade do |t|
    t.string "uslno", limit: 50, null: false
    t.string "matnr", limit: 50, null: false
    t.string "werks", limit: 4, null: false
    t.string "lgort", limit: 4, null: false
    t.string "charg", limit: 10, null: false
    t.decimal "clabs", precision: 12, scale: 3, default: "0.0"
    t.string "meins", limit: 3, null: false
    t.string "maktx", limit: 250, null: false
    t.text "vfdat", null: false
    t.string "status", limit: 2, default: "N"
    t.string "reason", limit: 60
    t.string "from_batch", limit: 40
    t.string "to_batch", limit: 40
    t.string "lifnr", limit: 10, default: ""
    t.string "name1", limit: 50, default: ""
    t.string "sup_batchno", limit: 50, default: ""
    t.string "lot_num", limit: 20, default: ""
    t.datetime "created_at"
  end

  create_table "mst_vendors", force: :cascade do |t|
    t.string "vendor_group_code", limit: 30
    t.string "vendor_code", limit: 4
    t.string "vendor_title", limit: 10
    t.string "vendor_firstname", limit: 60
    t.string "vendor_lastname", limit: 60
    t.string "status", limit: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "po_masters", id: false, force: :cascade do |t|
    t.integer "id"
    t.string "po_number", limit: 40
    t.string "po_item", limit: 40
    t.datetime "po_date"
    t.string "item_code", limit: 30
    t.string "item_description", limit: 100
    t.string "uom", limit: 30
    t.string "po_quantity", limit: 20
    t.string "pending_qty", limit: 20
    t.string "supplier_name", limit: 40
    t.string "supplier_id", limit: 20
    t.string "created_by", limit: 10
    t.string "updated_by", limit: 10
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "gst_number", limit: 30
    t.string "po_category", limit: 3
    t.string "plant", limit: 4
    t.string "str_loc", limit: 4
    t.string "document_no", limit: 20
    t.string "sap_batch_no", limit: 10
    t.string "status", limit: 1, default: "Y"
    t.string "vbelp_st", limit: 6
    t.string "charg", limit: 10
    t.decimal "sap_po_qty", precision: 12, scale: 3, default: "0.0"
    t.decimal "sap_po_res_qty", precision: 12, scale: 3, default: "0.0"
  end

  create_table "rfid_details", force: :cascade do |t|
    t.string "usage_plant"
    t.string "rfid_tag"
    t.string "reference_no"
    t.decimal "tare_wt"
    t.datetime "validity_dt"
    t.string "status"
    t.string "action_status", default: "open"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "settings", force: :cascade do |t|
    t.integer "weigment_mode", default: 0
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "reason_for_mode_change"
  end

  create_table "t10", id: false, force: :cascade do |t|
    t.text "t"
    t.string "sap_batch", limit: 20
  end

  create_table "transport_vehicle_masters", force: :cascade do |t|
    t.integer "vehicle_group", default: 0
    t.string "transporter_name"
    t.string "vehicle_type"
    t.string "truck_no"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "trn_mat_receipt_json", id: false, force: :cascade do |t|
    t.string "mobunqno", limit: 10
    t.string "bldat", limit: 10
    t.string "bktxt", limit: 25
    t.string "fmatnr", limit: 40
    t.string "fwerks", limit: 4
    t.string "flgort", limit: 4
    t.string "fcharg", limit: 10
    t.string "fmeins", limit: 3
    t.decimal "mengea", precision: 13, scale: 3, default: "0.0"
    t.string "twerks", limit: 4
    t.string "tlgort", limit: 4
    t.decimal "menged", precision: 13, scale: 3
    t.decimal "mengee", precision: 13, scale: 3
  end

  create_table "trn_mat_receipts", force: :cascade do |t|
    t.string "from_plant", limit: 4
    t.string "from_str_loc", limit: 4
    t.string "to_plant", limit: 4
    t.string "to_str_loc", limit: 4
    t.string "tran_type", limit: 30
    t.string "tran_ref_no", limit: 30
    t.string "rfid_tag", limit: 40
    t.string "req_no", limit: 30
    t.string "mat_group", limit: 40
    t.string "mat_code", limit: 40
    t.string "mat_desc", limit: 40
    t.string "mat_uom", limit: 4
    t.decimal "mat_qty", precision: 12, scale: 3
    t.decimal "issue_qty", precision: 12, scale: 3
    t.decimal "received_qty", precision: 12, scale: 3
    t.decimal "variance_qty", precision: 12, scale: 3
    t.datetime "issue_dt"
    t.datetime "expiry_dt"
    t.string "sup_roll_ref", limit: 20
    t.bigint "user_id"
    t.string "sap_batch", limit: 30
    t.string "mat_received_status", default: "N"
    t.string "sap_docref", limit: 40
    t.string "sap_status", default: "N"
    t.string "sap_err_msg", limit: 50
    t.datetime "sap_trn_dttime"
    t.datetime "sap_upd_dttime"
    t.string "action_status", default: "open"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["rfid_tag", "mat_code", "req_no"], name: "uniq_rfid_code_req_no", unique: true
    t.index ["user_id"], name: "index_trn_mat_receipts_on_user_id"
  end

  create_table "trn_mat_requisition_hdrs", force: :cascade do |t|
    t.string "plant", limit: 4
    t.string "str_loc", limit: 4
    t.string "req_no", limit: 40
    t.datetime "req_dt"
    t.integer "sequence_number"
    t.string "vendor_code", limit: 50
    t.bigint "user_id"
    t.string "action_status", default: "open"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_trn_mat_requisition_hdrs_on_user_id"
  end

  create_table "trn_mat_requisition_items", force: :cascade do |t|
    t.string "req_no", limit: 10
    t.string "mat_code", limit: 40
    t.string "mat_desc", limit: 30
    t.string "mat_uom", limit: 3
    t.string "status", limit: 15
    t.string "mat_group", limit: 10
    t.string "str_loc", limit: 4
    t.string "str_plant", limit: 4
    t.integer "priority"
    t.bigint "trn_mat_requisition_hdr_id"
    t.decimal "mat_qty", precision: 12, scale: 3
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["trn_mat_requisition_hdr_id"], name: "index_trn_mat_requisition_items_on_trn_mat_requisition_hdr_id"
  end

  create_table "trn_sto_issue_dtls_json", id: false, force: :cascade do |t|
    t.string "mobunqno", limit: 10
    t.integer "ebelp"
    t.string "reswk", limit: 4
    t.string "reslo", limit: 4
    t.string "matnr", limit: 40
    t.string "ewerk", limit: 4
    t.string "lgort", limit: 4
    t.decimal "bstmg", precision: 12
    t.string "bstme", limit: 4
    t.string "charg", limit: 10
    t.string "eeind", limit: 10
  end

  create_table "trn_veh_registration_dtls", force: :cascade do |t|
    t.string "truck_reg_no"
    t.datetime "truck_reg_date"
    t.string "inward_type"
    t.string "truck_from"
    t.string "source_plant"
    t.string "source_str_loc"
    t.string "truck_no"
    t.string "truck_type"
    t.string "trip_type"
    t.string "transport_code"
    t.string "transport_name"
    t.string "driver_name"
    t.string "driver_phone"
    t.string "driver_license"
    t.decimal "truck_gross_wt", precision: 10, scale: 2
    t.decimal "truck_tare_wt", precision: 10, scale: 2
    t.decimal "truck_net_wt", precision: 10, scale: 2
    t.integer "action_status", default: 0
    t.integer "no_of_items", default: 0
    t.string "material_description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "empty_weight_submit_flag", default: false
    t.boolean "gross_weight_submit_flag", default: false
    t.integer "weighment_mode", default: 0
    t.string "prepared_by"
    t.string "gate_no"
  end

  create_table "trn_wh_issue_dtls", force: :cascade do |t|
    t.string "wh_loc_id", limit: 30
    t.string "issue_docno", limit: 30
    t.string "rfid_tag", limit: 40
    t.string "mat_desc", limit: 50
    t.string "mat_uom", limit: 3
    t.string "sap_batch", limit: 30
    t.string "mat_code", limit: 30
    t.decimal "issued_qty", precision: 12, scale: 3
    t.bigint "trn_wh_issue_hdr_id"
    t.string "source_plant", limit: 4
    t.string "source_str_loc", limit: 4
    t.string "mat_group", limit: 30
    t.string "tran_type", limit: 30
    t.string "sup_roll_ref", limit: 20
    t.string "vendor_code", limit: 30
    t.string "vendor_name", limit: 50
    t.string "status", default: "open"
    t.datetime "expiry_dt"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "trns_status", limit: 1, default: "N"
    t.decimal "sequence_number", precision: 12, default: "0"
    t.decimal "transfer_lot", precision: 12, default: "0"
    t.string "fefo_reason"
    t.index ["trn_wh_issue_hdr_id"], name: "index_trn_wh_issue_dtls_on_trn_wh_issue_hdr_id"
  end

  create_table "trn_wh_issue_hdrs", force: :cascade do |t|
    t.string "plant", limit: 4
    t.string "str_loc", limit: 4
    t.string "to_plant", limit: 4
    t.string "to_str_loc", limit: 4
    t.string "req_no", limit: 30
    t.datetime "req_dt"
    t.integer "sequence_number"
    t.string "mat_group", limit: 30
    t.string "mat_desc", limit: 50
    t.string "mat_code", limit: 40
    t.string "mat_uom", limit: 10
    t.string "required_qty"
    t.string "issue_docno", limit: 50
    t.string "issue_docdt"
    t.string "issued_qty"
    t.bigint "user_id"
    t.string "action_status", default: "open"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_trn_wh_issue_hdrs_on_user_id"
  end

  create_table "trn_wh_request_dtl_items", force: :cascade do |t|
    t.string "prq_docno", limit: 40
    t.string "source_plant", limit: 4
    t.string "source_str_loc", limit: 4
    t.string "to_plant", limit: 4
    t.string "to_str_loc", limit: 4
    t.string "req_no", limit: 40
    t.datetime "req_dt"
    t.datetime "delievery_dt"
    t.integer "sequence_number"
    t.string "mat_group", limit: 40
    t.string "vendor_batch", limit: 20
    t.string "rfid_tag", limit: 40
    t.string "mat_desc", limit: 50
    t.string "mat_code", limit: 16
    t.string "mat_uom", limit: 3
    t.decimal "required_qty", precision: 12, scale: 3
    t.decimal "assigned_qty", precision: 12, scale: 3
    t.decimal "loaded_qty", precision: 12, scale: 3
    t.string "issue_batch", limit: 40
    t.decimal "issue_batch_qty", precision: 12, scale: 3
    t.string "tran_type", limit: 40
    t.string "sto_ref", limit: 40
    t.string "sto_ref_pdf_path", limit: 100
    t.string "sap_status", default: "N"
    t.string "sap_err_msg", limit: 50
    t.datetime "sap_upd_dttime"
    t.bigint "user_id"
    t.string "action_status", default: "open"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_trn_wh_request_dtl_items_on_user_id"
  end

  create_table "trn_wh_request_dtls", force: :cascade do |t|
    t.string "prq_docno", limit: 40
    t.string "source_plant", limit: 4
    t.string "source_str_loc", limit: 4
    t.string "to_plant", limit: 4
    t.string "to_str_loc", limit: 4
    t.string "req_no", limit: 40
    t.datetime "req_dt"
    t.datetime "delievery_dt"
    t.integer "sequence_number"
    t.string "mat_group", limit: 40
    t.string "mat_desc", limit: 50
    t.string "mat_code", limit: 16
    t.string "mat_uom", limit: 3
    t.decimal "required_qty", precision: 12, scale: 3
    t.decimal "assigned_qty", precision: 12, scale: 3
    t.decimal "loaded_qty", precision: 12, scale: 3
    t.string "issue_batch", limit: 40
    t.decimal "issue_batch_qty", precision: 12, scale: 3
    t.string "tran_type", limit: 40
    t.string "sto_ref", limit: 40
    t.string "sto_ref_pdf_path", limit: 100
    t.string "sap_status", default: "N"
    t.string "sap_err_msg", limit: 50
    t.datetime "sap_upd_dttime"
    t.bigint "user_id"
    t.string "action_status", default: "open"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_trn_wh_request_dtls_on_user_id"
  end

  create_table "trn_wh_request_dtls_json", id: false, force: :cascade do |t|
    t.string "mobunqno", limit: 10
    t.integer "ebelp"
    t.string "reswk", limit: 4
    t.string "reslo", limit: 4
    t.string "matnr", limit: 40
    t.string "ewerk", limit: 4
    t.string "lgort", limit: 4
    t.decimal "bstmg", precision: 12, scale: 3
    t.string "bstme", limit: 4
    t.string "charg", limit: 10
    t.string "eeind", limit: 10
  end

  create_table "trn_wh_transport_dtls", force: :cascade do |t|
    t.string "prq_docno", limit: 20
    t.string "transport_name", limit: 20
    t.string "driver_name", limit: 20
    t.string "driver_phone", limit: 20
    t.string "truck_number", limit: 20
    t.string "driver_licence", limit: 20
    t.string "bill_no", limit: 20
    t.datetime "delievery_dt"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["prq_docno"], name: "uniq_prq_docno", unique: true
  end

  create_table "trn_wip_stocks", force: :cascade do |t|
    t.string "rfid_tag", limit: 30
    t.string "plant", limit: 4
    t.string "str_loc", limit: 30
    t.string "mat_group", limit: 10
    t.string "mat_code", limit: 40
    t.string "mat_desc", limit: 40
    t.string "mat_uom", limit: 3
    t.string "mat_qty"
    t.decimal "received_qty", precision: 12, scale: 3
    t.decimal "cons_qty", precision: 12, scale: 3
    t.decimal "bal_qty"
    t.string "comp_lotno", limit: 10
    t.string "sap_batch", limit: 10
    t.datetime "expiry_dt"
    t.string "rfid_status", default: "open"
    t.string "action_status", default: "open"
    t.datetime "load_dttime"
    t.decimal "rm_gross_wt", precision: 12, scale: 3
    t.decimal "tare_wt", precision: 12, scale: 3
    t.decimal "rm_empty_shell_wt", precision: 12, scale: 3
    t.decimal "rm_net_wt", precision: 12, scale: 3
    t.string "vendor_batch", limit: 20
    t.string "unload_type", limit: 10
    t.bigint "user_id"
    t.string "req_no", limit: 10
    t.string "comp_batchno", limit: 10
    t.string "batch_reference"
    t.string "mat_group_name", limit: 30
    t.string "station"
    t.string "work_center"
    t.decimal "gross_wt", precision: 12, scale: 3
    t.datetime "pallet_rfid_date"
    t.datetime "comp_rfid_date"
    t.string "vendor_name"
    t.string "vendor_code", limit: 10
    t.string "stk_updflag"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status"
    t.index ["user_id"], name: "index_trn_wip_stocks_on_user_id"
  end

  create_table "trt_msts", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "vendor_mst", primary_key: "vendor_code", id: :string, limit: 20, force: :cascade do |t|
    t.serial "pk_vendor_id", null: false
    t.string "vendor_title", limit: 10
    t.string "vendor_firstname", limit: 60, null: false
    t.string "vendor_lastname", limit: 60
    t.string "vendor_class", limit: 30
    t.string "vendor_group_code", limit: 30
    t.string "address1", limit: 50
    t.string "address2", limit: 50
    t.string "address3", limit: 50
    t.string "status", limit: 1, default: "A"
    t.datetime "created_datetime"
    t.datetime "modified_datetime"
  end

  create_table "wh_bundle_types", id: false, force: :cascade do |t|
    t.bigserial "id", null: false
    t.string "bundle_type", limit: 50, default: ""
    t.decimal "bundle_wt", precision: 12, scale: 3
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "wh_material_storages", id: :serial, force: :cascade do |t|
    t.string "ge_doc_no", limit: 10
    t.string "plant", limit: 4
    t.string "str_loc", limit: 10
    t.string "mat_group", limit: 10
    t.string "mat_code", limit: 40
    t.string "mat_desc", limit: 40
    t.string "mat_uom", limit: 3
    t.string "grn_no", limit: 10
    t.decimal "grn_qty", precision: 12, scale: 3
    t.string "grn_date", limit: 10
    t.string "vendor_batch", limit: 20
    t.datetime "mfg_date"
    t.string "expiry_dt", limit: 10
    t.string "wh_loc_id", limit: 10
    t.string "wh_loc_rfid", limit: 40
    t.decimal "wh_loc_qty", precision: 12, scale: 3
    t.decimal "wh_picked_qty", precision: 12, scale: 3
    t.decimal "wh_balance_qty", precision: 12, scale: 3
    t.string "wh_hold_reason", limit: 30
    t.string "sup_roll_ref", limit: 20
    t.string "vendor_code", limit: 10
    t.string "vendor_name", limit: 50
    t.string "sap_batch", limit: 10
    t.string "sap_status", limit: 1, default: "N"
    t.string "stock_status", limit: 10
    t.string "status", limit: 10
    t.string "action_status", limit: 6, default: "open"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "sup_gross_wt", limit: 20
    t.string "sup_net_wt", limit: 20, default: ""
    t.string "sup_length_mtr", limit: 20, default: ""
  end

  create_table "wh_material_stroages_backup", id: false, force: :cascade do |t|
    t.integer "id"
    t.string "ge_doc_no", limit: 10
    t.string "plant", limit: 4
    t.string "str_loc", limit: 10
    t.string "mat_group", limit: 10
    t.text "mat_code"
    t.string "mat_desc", limit: 40
    t.string "mat_uom", limit: 3
    t.string "grn_no", limit: 10
    t.decimal "grn_qty", precision: 12, scale: 3
    t.string "grn_date", limit: 10
    t.string "vendor_batch", limit: 20
    t.datetime "mfg_date"
    t.string "expiry_dt", limit: 10
    t.string "wh_loc_id", limit: 10
    t.string "wh_loc_rfid", limit: 30
    t.decimal "wh_loc_qty", precision: 12, scale: 3
    t.decimal "wh_picked_qty", precision: 12, scale: 3
    t.decimal "wh_balance_qty", precision: 12, scale: 3
    t.string "wh_hold_reason", limit: 30
    t.string "sup_roll_ref", limit: 20
    t.string "vendor_code", limit: 10
    t.string "vendor_name", limit: 50
    t.string "sap_batch", limit: 10
    t.string "sap_status", limit: 1
    t.string "stock_status", limit: 10
    t.string "status", limit: 10
    t.string "action_status", limit: 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wh_sto_dtls", force: :cascade do |t|
    t.string "trns_doc_no", limit: 20
    t.datetime "trns_doc_date"
    t.datetime "req_dt"
    t.string "sto_no", limit: 20
    t.string "req_no", limit: 40
    t.string "plant", limit: 4
    t.string "str_loc", limit: 4
    t.string "to_plant", limit: 4
    t.string "source_plant", limit: 4
    t.string "source_str_loc", limit: 4
    t.string "mat_group_name", limit: 20
    t.string "po_item", limit: 5
    t.string "mat_code", limit: 40
    t.string "mat_desc", limit: 40
    t.string "mat_uom", limit: 2, default: "KG"
    t.string "mat_batch", limit: 20
    t.string "vbelp_st", limit: 10
    t.string "charg", limit: 10
    t.string "lot_no", limit: 40
    t.decimal "sap_batch_qty", precision: 12, scale: 3
    t.datetime "expirty_date"
    t.string "rfid_tag", limit: 40
    t.integer "pallet_no"
    t.decimal "trns_gross_wt", precision: 12, scale: 3
    t.decimal "trns_tare_wt", precision: 12, scale: 3
    t.decimal "trns_net_wt", precision: 12, scale: 3
    t.decimal "transfer_lot", precision: 12, scale: 3
    t.string "trns_status", limit: 1, default: "N"
    t.datetime "trns_transfer_dt"
    t.datetime "trns_ack_update_dt"
    t.string "trns_err_msg", limit: 100
    t.integer "sequence_number"
    t.datetime "sto_date"
    t.string "action_status", limit: 10, default: "open"
    t.string "vendor_code", limit: 10
    t.string "vendor_name", limit: 50
    t.decimal "bundle_qty", precision: 12, scale: 3
    t.string "bundle_type", limit: 20
    t.decimal "std_wt", precision: 12, scale: 3
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "sto_no_ref", limit: 20
    t.string "sap_batch_ref", limit: 10
    t.decimal "rec_net_wt"
    t.decimal "excess_qty"
    t.string "excess_flag", default: "N"
    t.string "excess_status", limit: 30, default: "open"
    t.decimal "rec_bundle_qty"
    t.decimal "rec_diff_wt"
    t.string "fefo_reason"
  end

  create_table "wh_sto_hdrs", force: :cascade do |t|
    t.string "trns_doc_no", limit: 20
    t.datetime "trns_doc_date"
    t.string "sto_no", limit: 20
    t.string "plant", limit: 4
    t.string "str_loc", limit: 4
    t.string "to_plant", limit: 4
    t.string "truck_no", limit: 20
    t.string "truck_type", limit: 20
    t.string "trip_type", limit: 20
    t.string "transport_vendor", limit: 50
    t.string "driver_name", limit: 50
    t.string "driver_phone", limit: 10
    t.string "driver_license", limit: 20
    t.decimal "total_truck_wt", precision: 12, scale: 3
    t.decimal "empty_truck_wt", precision: 12, scale: 3
    t.decimal "truck_net_wt", precision: 12, scale: 3
    t.decimal "total_tare_wt", precision: 12, scale: 3
    t.decimal "total_mat_wt", precision: 12, scale: 3
    t.string "truck_flag", limit: 1, default: "N"
    t.string "action_status", default: "open"
    t.string "sap_status", default: "N"
    t.integer "sequence_number"
    t.datetime "sap_transfer_dt"
    t.datetime "sap_ack_update_dt"
    t.datetime "sto_date"
    t.string "dbname"
    t.string "ewaybil"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "truck_status", limit: 10, default: "open"
    t.datetime "vehicle_receiving_dt"
    t.string "no_of_bins"
    t.string "truck_route", limit: 6
    t.string "vendor", limit: 10
    t.string "truck_type_desc", limit: 50
    t.string "old_truck_no"
    t.string "old_transport_vendor"
    t.string "old_driver_name"
    t.string "old_driver_phone"
    t.string "old_vendor"
    t.string "old_truck_type"
    t.string "old_truck_type_desc"
  end

  create_table "wh_stock_transfers", force: :cascade do |t|
    t.string "document_no", limit: 40
    t.string "truck_no", limit: 15
    t.string "po_number", limit: 10
    t.string "trans_type", limit: 20
    t.decimal "received_qty", precision: 12, scale: 3
    t.string "mat_code", limit: 40
    t.string "mat_desc", limit: 40
    t.decimal "gross_weight", precision: 12, scale: 3
    t.decimal "tare_weight", precision: 12, scale: 3
    t.decimal "net_weight", precision: 12, scale: 3
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "from_plant", limit: 10
    t.string "from_str_loc", limit: 10
    t.string "mat_uom", limit: 10
    t.datetime "sto_dt"
    t.string "sup_roll_ref", limit: 20
    t.string "to_plant", limit: 4
    t.string "to_str_loc", limit: 4
    t.string "mat_group", limit: 5
    t.string "sap_batch", limit: 20
    t.string "expiry_dt", limit: 10
    t.string "action_status", limit: 10, default: "active"
  end

end
