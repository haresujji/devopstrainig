require 'test_helper'

class TrnWhRequestDtlItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trn_wh_request_dtl_item = trn_wh_request_dtl_items(:one)
  end

  test "should get index" do
    get trn_wh_request_dtl_items_url
    assert_response :success
  end

  test "should get new" do
    get new_trn_wh_request_dtl_item_url
    assert_response :success
  end

  test "should create trn_wh_request_dtl_item" do
    assert_difference('TrnWhRequestDtlItem.count') do
      post trn_wh_request_dtl_items_url, params: { trn_wh_request_dtl_item: {  } }
    end

    assert_redirected_to trn_wh_request_dtl_item_url(TrnWhRequestDtlItem.last)
  end

  test "should show trn_wh_request_dtl_item" do
    get trn_wh_request_dtl_item_url(@trn_wh_request_dtl_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_trn_wh_request_dtl_item_url(@trn_wh_request_dtl_item)
    assert_response :success
  end

  test "should update trn_wh_request_dtl_item" do
    patch trn_wh_request_dtl_item_url(@trn_wh_request_dtl_item), params: { trn_wh_request_dtl_item: {  } }
    assert_redirected_to trn_wh_request_dtl_item_url(@trn_wh_request_dtl_item)
  end

  test "should destroy trn_wh_request_dtl_item" do
    assert_difference('TrnWhRequestDtlItem.count', -1) do
      delete trn_wh_request_dtl_item_url(@trn_wh_request_dtl_item)
    end

    assert_redirected_to trn_wh_request_dtl_items_url
  end
end
