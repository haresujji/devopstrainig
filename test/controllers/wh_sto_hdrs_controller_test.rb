require 'test_helper'

class WhStoHdrsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wh_sto_hdr = wh_sto_hdrs(:one)
  end

  test "should get index" do
    get wh_sto_hdrs_url
    assert_response :success
  end

  test "should get new" do
    get new_wh_sto_hdr_url
    assert_response :success
  end

  test "should create wh_sto_hdr" do
    assert_difference('WhStoHdr.count') do
      post wh_sto_hdrs_url, params: { wh_sto_hdr: {  } }
    end

    assert_redirected_to wh_sto_hdr_url(WhStoHdr.last)
  end

  test "should show wh_sto_hdr" do
    get wh_sto_hdr_url(@wh_sto_hdr)
    assert_response :success
  end

  test "should get edit" do
    get edit_wh_sto_hdr_url(@wh_sto_hdr)
    assert_response :success
  end

  test "should update wh_sto_hdr" do
    patch wh_sto_hdr_url(@wh_sto_hdr), params: { wh_sto_hdr: {  } }
    assert_redirected_to wh_sto_hdr_url(@wh_sto_hdr)
  end

  test "should destroy wh_sto_hdr" do
    assert_difference('WhStoHdr.count', -1) do
      delete wh_sto_hdr_url(@wh_sto_hdr)
    end

    assert_redirected_to wh_sto_hdrs_url
  end
end
