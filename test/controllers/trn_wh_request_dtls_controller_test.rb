require 'test_helper'

class TrnWhRequestDtlsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trn_wh_request_dtl = trn_wh_request_dtls(:one)
  end

  test "should get index" do
    get trn_wh_request_dtls_url
    assert_response :success
  end

  test "should get new" do
    get new_trn_wh_request_dtl_url
    assert_response :success
  end

  test "should create trn_wh_request_dtl" do
    assert_difference('TrnWhRequestDtl.count') do
      post trn_wh_request_dtls_url, params: { trn_wh_request_dtl: {  } }
    end

    assert_redirected_to trn_wh_request_dtl_url(TrnWhRequestDtl.last)
  end

  test "should show trn_wh_request_dtl" do
    get trn_wh_request_dtl_url(@trn_wh_request_dtl)
    assert_response :success
  end

  test "should get edit" do
    get edit_trn_wh_request_dtl_url(@trn_wh_request_dtl)
    assert_response :success
  end

  test "should update trn_wh_request_dtl" do
    patch trn_wh_request_dtl_url(@trn_wh_request_dtl), params: { trn_wh_request_dtl: {  } }
    assert_redirected_to trn_wh_request_dtl_url(@trn_wh_request_dtl)
  end

  test "should destroy trn_wh_request_dtl" do
    assert_difference('TrnWhRequestDtl.count', -1) do
      delete trn_wh_request_dtl_url(@trn_wh_request_dtl)
    end

    assert_redirected_to trn_wh_request_dtls_url
  end
end
