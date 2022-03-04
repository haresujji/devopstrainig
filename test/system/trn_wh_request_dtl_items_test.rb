require "application_system_test_case"

class TrnWhRequestDtlItemsTest < ApplicationSystemTestCase
  setup do
    @trn_wh_request_dtl_item = trn_wh_request_dtl_items(:one)
  end

  test "visiting the index" do
    visit trn_wh_request_dtl_items_url
    assert_selector "h1", text: "Trn Wh Request Dtl Items"
  end

  test "creating a Trn wh request dtl item" do
    visit trn_wh_request_dtl_items_url
    click_on "New Trn Wh Request Dtl Item"

    click_on "Create Trn wh request dtl item"

    assert_text "Trn wh request dtl item was successfully created"
    click_on "Back"
  end

  test "updating a Trn wh request dtl item" do
    visit trn_wh_request_dtl_items_url
    click_on "Edit", match: :first

    click_on "Update Trn wh request dtl item"

    assert_text "Trn wh request dtl item was successfully updated"
    click_on "Back"
  end

  test "destroying a Trn wh request dtl item" do
    visit trn_wh_request_dtl_items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Trn wh request dtl item was successfully destroyed"
  end
end
