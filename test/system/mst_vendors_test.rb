require "application_system_test_case"

class MstVendorsTest < ApplicationSystemTestCase
  setup do
    @mst_vendor = mst_vendors(:one)
  end

  test "visiting the index" do
    visit mst_vendors_url
    assert_selector "h1", text: "Mst Vendors"
  end

  test "creating a Mst vendor" do
    visit mst_vendors_url
    click_on "New Mst Vendor"

    fill_in "Status", with: @mst_vendor.status
    fill_in "Vendor code", with: @mst_vendor.vendor_code
    fill_in "Vendor firstname", with: @mst_vendor.vendor_firstname
    fill_in "Vendor group code", with: @mst_vendor.vendor_group_code
    fill_in "Vendor lastname", with: @mst_vendor.vendor_lastname
    fill_in "Vendor title", with: @mst_vendor.vendor_title
    click_on "Create Mst vendor"

    assert_text "Mst vendor was successfully created"
    click_on "Back"
  end

  test "updating a Mst vendor" do
    visit mst_vendors_url
    click_on "Edit", match: :first

    fill_in "Status", with: @mst_vendor.status
    fill_in "Vendor code", with: @mst_vendor.vendor_code
    fill_in "Vendor firstname", with: @mst_vendor.vendor_firstname
    fill_in "Vendor group code", with: @mst_vendor.vendor_group_code
    fill_in "Vendor lastname", with: @mst_vendor.vendor_lastname
    fill_in "Vendor title", with: @mst_vendor.vendor_title
    click_on "Update Mst vendor"

    assert_text "Mst vendor was successfully updated"
    click_on "Back"
  end

  test "destroying a Mst vendor" do
    visit mst_vendors_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Mst vendor was successfully destroyed"
  end
end
