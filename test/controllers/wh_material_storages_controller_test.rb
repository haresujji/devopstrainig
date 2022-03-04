require 'test_helper'

class WhMaterialStoragesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wh_material_storage = wh_material_storages(:one)
  end

  test "should get index" do
    get wh_material_storages_url
    assert_response :success
  end

  test "should get new" do
    get new_wh_material_storage_url
    assert_response :success
  end

  test "should create wh_material_storage" do
    assert_difference('WhMaterialStorage.count') do
      post wh_material_storages_url, params: { wh_material_storage: {  } }
    end

    assert_redirected_to wh_material_storage_url(WhMaterialStorage.last)
  end

  test "should show wh_material_storage" do
    get wh_material_storage_url(@wh_material_storage)
    assert_response :success
  end

  test "should get edit" do
    get edit_wh_material_storage_url(@wh_material_storage)
    assert_response :success
  end

  test "should update wh_material_storage" do
    patch wh_material_storage_url(@wh_material_storage), params: { wh_material_storage: {  } }
    assert_redirected_to wh_material_storage_url(@wh_material_storage)
  end

  test "should destroy wh_material_storage" do
    assert_difference('WhMaterialStorage.count', -1) do
      delete wh_material_storage_url(@wh_material_storage)
    end

    assert_redirected_to wh_material_storages_url
  end
end
