require 'test_helper'

class TrnWhTransportDtlsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trn_wh_transport_dtl = trn_wh_transport_dtls(:one)
  end

  test "should get index" do
    get trn_wh_transport_dtls_url
    assert_response :success
  end

  test "should get new" do
    get new_trn_wh_transport_dtl_url
    assert_response :success
  end

  test "should create trn_wh_transport_dtl" do
    assert_difference('TrnWhTransportDtl.count') do
      post trn_wh_transport_dtls_url, params: { trn_wh_transport_dtl: {  } }
    end

    assert_redirected_to trn_wh_transport_dtl_url(TrnWhTransportDtl.last)
  end

  test "should show trn_wh_transport_dtl" do
    get trn_wh_transport_dtl_url(@trn_wh_transport_dtl)
    assert_response :success
  end

  test "should get edit" do
    get edit_trn_wh_transport_dtl_url(@trn_wh_transport_dtl)
    assert_response :success
  end

  test "should update trn_wh_transport_dtl" do
    patch trn_wh_transport_dtl_url(@trn_wh_transport_dtl), params: { trn_wh_transport_dtl: {  } }
    assert_redirected_to trn_wh_transport_dtl_url(@trn_wh_transport_dtl)
  end

  test "should destroy trn_wh_transport_dtl" do
    assert_difference('TrnWhTransportDtl.count', -1) do
      delete trn_wh_transport_dtl_url(@trn_wh_transport_dtl)
    end

    assert_redirected_to trn_wh_transport_dtls_url
  end
end
