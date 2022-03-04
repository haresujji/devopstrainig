require 'test_helper'

class WhIssueHdrsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wh_issue_hdr = wh_issue_hdrs(:one)
  end

  test "should get index" do
    get wh_issue_hdrs_url
    assert_response :success
  end

  test "should get new" do
    get new_wh_issue_hdr_url
    assert_response :success
  end

  test "should create wh_issue_hdr" do
    assert_difference('WhIssueHdr.count') do
      post wh_issue_hdrs_url, params: { wh_issue_hdr: {  } }
    end

    assert_redirected_to wh_issue_hdr_url(WhIssueHdr.last)
  end

  test "should show wh_issue_hdr" do
    get wh_issue_hdr_url(@wh_issue_hdr)
    assert_response :success
  end

  test "should get edit" do
    get edit_wh_issue_hdr_url(@wh_issue_hdr)
    assert_response :success
  end

  test "should update wh_issue_hdr" do
    patch wh_issue_hdr_url(@wh_issue_hdr), params: { wh_issue_hdr: {  } }
    assert_redirected_to wh_issue_hdr_url(@wh_issue_hdr)
  end

  test "should destroy wh_issue_hdr" do
    assert_difference('WhIssueHdr.count', -1) do
      delete wh_issue_hdr_url(@wh_issue_hdr)
    end

    assert_redirected_to wh_issue_hdrs_url
  end
end
