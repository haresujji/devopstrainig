require 'test_helper'

class TrnMatRequisitionItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trn_mat_requisition_item = trn_mat_requisition_items(:one)
  end

  test "should get index" do
    get trn_mat_requisition_items_url
    assert_response :success
  end

  test "should get new" do
    get new_trn_mat_requisition_item_url
    assert_response :success
  end

  test "should create trn_mat_requisition_item" do
    assert_difference('TrnMatRequisitionItem.count') do
      post trn_mat_requisition_items_url, params: { trn_mat_requisition_item: { mat_code: @trn_mat_requisition_item.mat_code, mat_desc: @trn_mat_requisition_item.mat_desc, mat_qty: @trn_mat_requisition_item.mat_qty, mat_uom: @trn_mat_requisition_item.mat_uom, req_no: @trn_mat_requisition_item.req_no } }
    end

    assert_redirected_to trn_mat_requisition_item_url(TrnMatRequisitionItem.last)
  end

  test "should show trn_mat_requisition_item" do
    get trn_mat_requisition_item_url(@trn_mat_requisition_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_trn_mat_requisition_item_url(@trn_mat_requisition_item)
    assert_response :success
  end

  test "should update trn_mat_requisition_item" do
    patch trn_mat_requisition_item_url(@trn_mat_requisition_item), params: { trn_mat_requisition_item: { mat_code: @trn_mat_requisition_item.mat_code, mat_desc: @trn_mat_requisition_item.mat_desc, mat_qty: @trn_mat_requisition_item.mat_qty, mat_uom: @trn_mat_requisition_item.mat_uom, req_no: @trn_mat_requisition_item.req_no } }
    assert_redirected_to trn_mat_requisition_item_url(@trn_mat_requisition_item)
  end

  test "should destroy trn_mat_requisition_item" do
    assert_difference('TrnMatRequisitionItem.count', -1) do
      delete trn_mat_requisition_item_url(@trn_mat_requisition_item)
    end

    assert_redirected_to trn_mat_requisition_items_url
  end
end
