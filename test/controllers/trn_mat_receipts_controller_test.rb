require 'test_helper'

class TrnMatReceiptsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trn_mat_receipt = trn_mat_receipts(:one)
  end

  test "should get index" do
    get trn_mat_receipts_url
    assert_response :success
  end

  test "should get new" do
    get new_trn_mat_receipt_url
    assert_response :success
  end

  test "should create trn_mat_receipt" do
    assert_difference('TrnMatReceipt.count') do
      post trn_mat_receipts_url, params: { trn_mat_receipt: {  } }
    end

    assert_redirected_to trn_mat_receipt_url(TrnMatReceipt.last)
  end

  test "should show trn_mat_receipt" do
    get trn_mat_receipt_url(@trn_mat_receipt)
    assert_response :success
  end

  test "should get edit" do
    get edit_trn_mat_receipt_url(@trn_mat_receipt)
    assert_response :success
  end

  test "should update trn_mat_receipt" do
    patch trn_mat_receipt_url(@trn_mat_receipt), params: { trn_mat_receipt: {  } }
    assert_redirected_to trn_mat_receipt_url(@trn_mat_receipt)
  end

  test "should destroy trn_mat_receipt" do
    assert_difference('TrnMatReceipt.count', -1) do
      delete trn_mat_receipt_url(@trn_mat_receipt)
    end

    assert_redirected_to trn_mat_receipts_url
  end
end
