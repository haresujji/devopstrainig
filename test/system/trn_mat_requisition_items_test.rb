require "application_system_test_case"

class TrnMatRequisitionItemsTest < ApplicationSystemTestCase
  setup do
    @trn_mat_requisition_item = trn_mat_requisition_items(:one)
  end

  test "visiting the index" do
    visit trn_mat_requisition_items_url
    assert_selector "h1", text: "Trn Mat Requisition Items"
  end

  test "creating a Trn mat requisition item" do
    visit trn_mat_requisition_items_url
    click_on "New Trn Mat Requisition Item"

    fill_in "Mat code", with: @trn_mat_requisition_item.mat_code
    fill_in "Mat desc", with: @trn_mat_requisition_item.mat_desc
    fill_in "Mat qty", with: @trn_mat_requisition_item.mat_qty
    fill_in "Mat uom", with: @trn_mat_requisition_item.mat_uom
    fill_in "Req no", with: @trn_mat_requisition_item.req_no
    click_on "Create Trn mat requisition item"

    assert_text "Trn mat requisition item was successfully created"
    click_on "Back"
  end

  test "updating a Trn mat requisition item" do
    visit trn_mat_requisition_items_url
    click_on "Edit", match: :first

    fill_in "Mat code", with: @trn_mat_requisition_item.mat_code
    fill_in "Mat desc", with: @trn_mat_requisition_item.mat_desc
    fill_in "Mat qty", with: @trn_mat_requisition_item.mat_qty
    fill_in "Mat uom", with: @trn_mat_requisition_item.mat_uom
    fill_in "Req no", with: @trn_mat_requisition_item.req_no
    click_on "Update Trn mat requisition item"

    assert_text "Trn mat requisition item was successfully updated"
    click_on "Back"
  end

  test "destroying a Trn mat requisition item" do
    visit trn_mat_requisition_items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Trn mat requisition item was successfully destroyed"
  end
end
