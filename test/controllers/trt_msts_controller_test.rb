require 'test_helper'

class TrtMstsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trt_mst = trt_msts(:one)
  end

  test "should get index" do
    get trt_msts_url
    assert_response :success
  end

  test "should get new" do
    get new_trt_mst_url
    assert_response :success
  end

  test "should create trt_mst" do
    assert_difference('TrtMst.count') do
      post trt_msts_url, params: { trt_mst: {  } }
    end

    assert_redirected_to trt_mst_url(TrtMst.last)
  end

  test "should show trt_mst" do
    get trt_mst_url(@trt_mst)
    assert_response :success
  end

  test "should get edit" do
    get edit_trt_mst_url(@trt_mst)
    assert_response :success
  end

  test "should update trt_mst" do
    patch trt_mst_url(@trt_mst), params: { trt_mst: {  } }
    assert_redirected_to trt_mst_url(@trt_mst)
  end

  test "should destroy trt_mst" do
    assert_difference('TrtMst.count', -1) do
      delete trt_mst_url(@trt_mst)
    end

    assert_redirected_to trt_msts_url
  end
end
