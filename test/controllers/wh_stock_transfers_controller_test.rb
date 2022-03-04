require 'test_helper'

class WhStockTransfersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wh_stock_transfer = wh_stock_transfers(:one)
  end

  test "should get index" do
    get wh_stock_transfers_url
    assert_response :success
  end

  test "should get new" do
    get new_wh_stock_transfer_url
    assert_response :success
  end

  test "should create wh_stock_transfer" do
    assert_difference('WhStockTransfer.count') do
      post wh_stock_transfers_url, params: { wh_stock_transfer: { document_no: @wh_stock_transfer.document_no, gross_weight: @wh_stock_transfer.gross_weight, mat_code: @wh_stock_transfer.mat_code, mat_desc: @wh_stock_transfer.mat_desc, net_weight: @wh_stock_transfer.net_weight, po_number: @wh_stock_transfer.po_number, received_qty: @wh_stock_transfer.received_qty, tare_weight: @wh_stock_transfer.tare_weight, truck_no: @wh_stock_transfer.truck_no } }
    end

    assert_redirected_to wh_stock_transfer_url(WhStockTransfer.last)
  end

  test "should show wh_stock_transfer" do
    get wh_stock_transfer_url(@wh_stock_transfer)
    assert_response :success
  end

  test "should get edit" do
    get edit_wh_stock_transfer_url(@wh_stock_transfer)
    assert_response :success
  end

  test "should update wh_stock_transfer" do
    patch wh_stock_transfer_url(@wh_stock_transfer), params: { wh_stock_transfer: { document_no: @wh_stock_transfer.document_no, gross_weight: @wh_stock_transfer.gross_weight, mat_code: @wh_stock_transfer.mat_code, mat_desc: @wh_stock_transfer.mat_desc, net_weight: @wh_stock_transfer.net_weight, po_number: @wh_stock_transfer.po_number, received_qty: @wh_stock_transfer.received_qty, tare_weight: @wh_stock_transfer.tare_weight, truck_no: @wh_stock_transfer.truck_no } }
    assert_redirected_to wh_stock_transfer_url(@wh_stock_transfer)
  end

  test "should destroy wh_stock_transfer" do
    assert_difference('WhStockTransfer.count', -1) do
      delete wh_stock_transfer_url(@wh_stock_transfer)
    end

    assert_redirected_to wh_stock_transfers_url
  end
end
