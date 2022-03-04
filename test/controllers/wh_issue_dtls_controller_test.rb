require 'test_helper'

class WhIssueDtlsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wh_issue_dtl = wh_issue_dtls(:one)
  end

  test "should get index" do
    get wh_issue_dtls_url
    assert_response :success
  end

  test "should get new" do
    get new_wh_issue_dtl_url
    assert_response :success
  end

  test "should create wh_issue_dtl" do
    assert_difference('WhIssueDtl.count') do
      post wh_issue_dtls_url, params: { wh_issue_dtl: {  } }
    end

    assert_redirected_to wh_issue_dtl_url(WhIssueDtl.last)
  end

  test "should show wh_issue_dtl" do
    get wh_issue_dtl_url(@wh_issue_dtl)
    assert_response :success
  end

  test "should get edit" do
    get edit_wh_issue_dtl_url(@wh_issue_dtl)
    assert_response :success
  end

  test "should update wh_issue_dtl" do
    patch wh_issue_dtl_url(@wh_issue_dtl), params: { wh_issue_dtl: {  } }
    assert_redirected_to wh_issue_dtl_url(@wh_issue_dtl)
  end

  test "should destroy wh_issue_dtl" do
    assert_difference('WhIssueDtl.count', -1) do
      delete wh_issue_dtl_url(@wh_issue_dtl)
    end

    assert_redirected_to wh_issue_dtls_url
  end
end
