require 'test_helper'

class WhStoDtlsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wh_sto_dtl = wh_sto_dtls(:one)
  end

  test "should get index" do
    get wh_sto_dtls_url, as: :json
    assert_response :success
  end

  test "should create wh_sto_dtl" do
    assert_difference('WhStoDtl.count') do
      post wh_sto_dtls_url, params: { wh_sto_dtl: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show wh_sto_dtl" do
    get wh_sto_dtl_url(@wh_sto_dtl), as: :json
    assert_response :success
  end

  test "should update wh_sto_dtl" do
    patch wh_sto_dtl_url(@wh_sto_dtl), params: { wh_sto_dtl: {  } }, as: :json
    assert_response 200
  end

  test "should destroy wh_sto_dtl" do
    assert_difference('WhStoDtl.count', -1) do
      delete wh_sto_dtl_url(@wh_sto_dtl), as: :json
    end

    assert_response 204
  end
end
