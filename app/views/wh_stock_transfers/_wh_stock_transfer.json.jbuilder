json.extract! wh_stock_transfer, :id, :document_no, :truck_no, :po_number, :received_qty, :mat_code, :mat_desc, :gross_weight, :tare_weight, :net_weight, :created_at, :updated_at
json.url wh_stock_transfer_url(wh_stock_transfer, format: :json)
