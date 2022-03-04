require "application_system_test_case"

class WhStockTransfersTest < ApplicationSystemTestCase
  setup do
    @wh_stock_transfer = wh_stock_transfers(:one)
  end

  test "visiting the index" do
    visit wh_stock_transfers_url
    assert_selector "h1", text: "Wh Stock Transfers"
  end

  test "creating a Wh stock transfer" do
    visit wh_stock_transfers_url
    click_on "New Wh Stock Transfer"

    fill_in "Document no", with: @wh_stock_transfer.document_no
    fill_in "Gross weight", with: @wh_stock_transfer.gross_weight
    fill_in "Mat code", with: @wh_stock_transfer.mat_code
    fill_in "Mat desc", with: @wh_stock_transfer.mat_desc
    fill_in "Net weight", with: @wh_stock_transfer.net_weight
    fill_in "Po number", with: @wh_stock_transfer.po_number
    fill_in "Received qty", with: @wh_stock_transfer.received_qty
    fill_in "Tare weight", with: @wh_stock_transfer.tare_weight
    fill_in "Truck no", with: @wh_stock_transfer.truck_no
    click_on "Create Wh stock transfer"

    assert_text "Wh stock transfer was successfully created"
    click_on "Back"
  end

  test "updating a Wh stock transfer" do
    visit wh_stock_transfers_url
    click_on "Edit", match: :first

    fill_in "Document no", with: @wh_stock_transfer.document_no
    fill_in "Gross weight", with: @wh_stock_transfer.gross_weight
    fill_in "Mat code", with: @wh_stock_transfer.mat_code
    fill_in "Mat desc", with: @wh_stock_transfer.mat_desc
    fill_in "Net weight", with: @wh_stock_transfer.net_weight
    fill_in "Po number", with: @wh_stock_transfer.po_number
    fill_in "Received qty", with: @wh_stock_transfer.received_qty
    fill_in "Tare weight", with: @wh_stock_transfer.tare_weight
    fill_in "Truck no", with: @wh_stock_transfer.truck_no
    click_on "Update Wh stock transfer"

    assert_text "Wh stock transfer was successfully updated"
    click_on "Back"
  end

  test "destroying a Wh stock transfer" do
    visit wh_stock_transfers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Wh stock transfer was successfully destroyed"
  end
end
