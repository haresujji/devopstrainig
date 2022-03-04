require 'test_helper'

class TrnWhIssueHdrsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trn_wh_issue_hdr = trn_wh_issue_hdrs(:one)
  end

  test "should get index" do
    get trn_wh_issue_hdrs_url
    assert_response :success
  end

  test "should get new" do
    get new_trn_wh_issue_hdr_url
    assert_response :success
  end

  test "should create trn_wh_issue_hdr" do
    assert_difference('TrnWhIssueHdr.count') do
      post trn_wh_issue_hdrs_url, params: { trn_wh_issue_hdr: {  } }
    end

    assert_redirected_to trn_wh_issue_hdr_url(TrnWhIssueHdr.last)
  end

  test "should show trn_wh_issue_hdr" do
    get trn_wh_issue_hdr_url(@trn_wh_issue_hdr)
    assert_response :success
  end

  test "should get edit" do
    get edit_trn_wh_issue_hdr_url(@trn_wh_issue_hdr)
    assert_response :success
  end

  test "should update trn_wh_issue_hdr" do
    patch trn_wh_issue_hdr_url(@trn_wh_issue_hdr), params: { trn_wh_issue_hdr: {  } }
    assert_redirected_to trn_wh_issue_hdr_url(@trn_wh_issue_hdr)
  end

  test "should destroy trn_wh_issue_hdr" do
    assert_difference('TrnWhIssueHdr.count', -1) do
      delete trn_wh_issue_hdr_url(@trn_wh_issue_hdr)
    end

    assert_redirected_to trn_wh_issue_hdrs_url
  end
end
