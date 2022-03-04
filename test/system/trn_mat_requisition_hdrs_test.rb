require "application_system_test_case"

class TrnMatRequisitionHdrsTest < ApplicationSystemTestCase
  setup do
    @trn_mat_requisition_hdr = trn_mat_requisition_hdrs(:one)
  end

  test "visiting the index" do
    visit trn_mat_requisition_hdrs_url
    assert_selector "h1", text: "Trn Mat Requisition Hdrs"
  end

  test "creating a Trn mat requisition hdr" do
    visit trn_mat_requisition_hdrs_url
    click_on "New Trn Mat Requisition Hdr"

    fill_in "Action status", with: @trn_mat_requisition_hdr.action_status
    fill_in "Plant", with: @trn_mat_requisition_hdr.plant
    fill_in "Req dt", with: @trn_mat_requisition_hdr.req_dt
    fill_in "Req no", with: @trn_mat_requisition_hdr.req_no
    fill_in "Req shift", with: @trn_mat_requisition_hdr.req_shift
    fill_in "Str loc", with: @trn_mat_requisition_hdr.str_loc
    fill_in "User", with: @trn_mat_requisition_hdr.user_id
    fill_in "Vendor", with: @trn_mat_requisition_hdr.vendor_id
    click_on "Create Trn mat requisition hdr"

    assert_text "Trn mat requisition hdr was successfully created"
    click_on "Back"
  end

  test "updating a Trn mat requisition hdr" do
    visit trn_mat_requisition_hdrs_url
    click_on "Edit", match: :first

    fill_in "Action status", with: @trn_mat_requisition_hdr.action_status
    fill_in "Plant", with: @trn_mat_requisition_hdr.plant
    fill_in "Req dt", with: @trn_mat_requisition_hdr.req_dt
    fill_in "Req no", with: @trn_mat_requisition_hdr.req_no
    fill_in "Req shift", with: @trn_mat_requisition_hdr.req_shift
    fill_in "Str loc", with: @trn_mat_requisition_hdr.str_loc
    fill_in "User", with: @trn_mat_requisition_hdr.user_id
    fill_in "Vendor", with: @trn_mat_requisition_hdr.vendor_id
    click_on "Update Trn mat requisition hdr"

    assert_text "Trn mat requisition hdr was successfully updated"
    click_on "Back"
  end

  test "destroying a Trn mat requisition hdr" do
    visit trn_mat_requisition_hdrs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Trn mat requisition hdr was successfully destroyed"
  end
end
