require 'test_helper'

class TrnMatRequisitionHdrsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trn_mat_requisition_hdr = trn_mat_requisition_hdrs(:one)
  end

  test "should get index" do
    get trn_mat_requisition_hdrs_url
    assert_response :success
  end

  test "should get new" do
    get new_trn_mat_requisition_hdr_url
    assert_response :success
  end

  test "should create trn_mat_requisition_hdr" do
    assert_difference('TrnMatRequisitionHdr.count') do
      post trn_mat_requisition_hdrs_url, params: { trn_mat_requisition_hdr: { action_status: @trn_mat_requisition_hdr.action_status, plant: @trn_mat_requisition_hdr.plant, req_dt: @trn_mat_requisition_hdr.req_dt, req_no: @trn_mat_requisition_hdr.req_no, req_shift: @trn_mat_requisition_hdr.req_shift, str_loc: @trn_mat_requisition_hdr.str_loc, user_id: @trn_mat_requisition_hdr.user_id, vendor_id: @trn_mat_requisition_hdr.vendor_id } }
    end

    assert_redirected_to trn_mat_requisition_hdr_url(TrnMatRequisitionHdr.last)
  end

  test "should show trn_mat_requisition_hdr" do
    get trn_mat_requisition_hdr_url(@trn_mat_requisition_hdr)
    assert_response :success
  end

  test "should get edit" do
    get edit_trn_mat_requisition_hdr_url(@trn_mat_requisition_hdr)
    assert_response :success
  end

  test "should update trn_mat_requisition_hdr" do
    patch trn_mat_requisition_hdr_url(@trn_mat_requisition_hdr), params: { trn_mat_requisition_hdr: { action_status: @trn_mat_requisition_hdr.action_status, plant: @trn_mat_requisition_hdr.plant, req_dt: @trn_mat_requisition_hdr.req_dt, req_no: @trn_mat_requisition_hdr.req_no, req_shift: @trn_mat_requisition_hdr.req_shift, str_loc: @trn_mat_requisition_hdr.str_loc, user_id: @trn_mat_requisition_hdr.user_id, vendor_id: @trn_mat_requisition_hdr.vendor_id } }
    assert_redirected_to trn_mat_requisition_hdr_url(@trn_mat_requisition_hdr)
  end

  test "should destroy trn_mat_requisition_hdr" do
    assert_difference('TrnMatRequisitionHdr.count', -1) do
      delete trn_mat_requisition_hdr_url(@trn_mat_requisition_hdr)
    end

    assert_redirected_to trn_mat_requisition_hdrs_url
  end
end
