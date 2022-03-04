require 'test_helper'

class WhBundleTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wh_bundle_type = wh_bundle_types(:one)
  end

  test "should get index" do
    get wh_bundle_types_url, as: :json
    assert_response :success
  end

  test "should create wh_bundle_type" do
    assert_difference('WhBundleType.count') do
      post wh_bundle_types_url, params: { wh_bundle_type: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show wh_bundle_type" do
    get wh_bundle_type_url(@wh_bundle_type), as: :json
    assert_response :success
  end

  test "should update wh_bundle_type" do
    patch wh_bundle_type_url(@wh_bundle_type), params: { wh_bundle_type: {  } }, as: :json
    assert_response 200
  end

  test "should destroy wh_bundle_type" do
    assert_difference('WhBundleType.count', -1) do
      delete wh_bundle_type_url(@wh_bundle_type), as: :json
    end

    assert_response 204
  end
end
