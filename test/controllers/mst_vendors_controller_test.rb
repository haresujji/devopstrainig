require 'test_helper'

class MstVendorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mst_vendor = mst_vendors(:one)
  end

  test "should get index" do
    get mst_vendors_url
    assert_response :success
  end

  test "should get new" do
    get new_mst_vendor_url
    assert_response :success
  end

  test "should create mst_vendor" do
    assert_difference('MstVendor.count') do
      post mst_vendors_url, params: { mst_vendor: { status: @mst_vendor.status, vendor_code: @mst_vendor.vendor_code, vendor_firstname: @mst_vendor.vendor_firstname, vendor_group_code: @mst_vendor.vendor_group_code, vendor_lastname: @mst_vendor.vendor_lastname, vendor_title: @mst_vendor.vendor_title } }
    end

    assert_redirected_to mst_vendor_url(MstVendor.last)
  end

  test "should show mst_vendor" do
    get mst_vendor_url(@mst_vendor)
    assert_response :success
  end

  test "should get edit" do
    get edit_mst_vendor_url(@mst_vendor)
    assert_response :success
  end

  test "should update mst_vendor" do
    patch mst_vendor_url(@mst_vendor), params: { mst_vendor: { status: @mst_vendor.status, vendor_code: @mst_vendor.vendor_code, vendor_firstname: @mst_vendor.vendor_firstname, vendor_group_code: @mst_vendor.vendor_group_code, vendor_lastname: @mst_vendor.vendor_lastname, vendor_title: @mst_vendor.vendor_title } }
    assert_redirected_to mst_vendor_url(@mst_vendor)
  end

  test "should destroy mst_vendor" do
    assert_difference('MstVendor.count', -1) do
      delete mst_vendor_url(@mst_vendor)
    end

    assert_redirected_to mst_vendors_url
  end
end
