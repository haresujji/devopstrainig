require "application_system_test_case"

class WhStoHdrsTest < ApplicationSystemTestCase
  setup do
    @wh_sto_hdr = wh_sto_hdrs(:one)
  end

  test "visiting the index" do
    visit wh_sto_hdrs_url
    assert_selector "h1", text: "Wh Sto Hdrs"
  end

  test "creating a Wh sto hdr" do
    visit wh_sto_hdrs_url
    click_on "New Wh Sto Hdr"

    click_on "Create Wh sto hdr"

    assert_text "Wh sto hdr was successfully created"
    click_on "Back"
  end

  test "updating a Wh sto hdr" do
    visit wh_sto_hdrs_url
    click_on "Edit", match: :first

    click_on "Update Wh sto hdr"

    assert_text "Wh sto hdr was successfully updated"
    click_on "Back"
  end

  test "destroying a Wh sto hdr" do
    visit wh_sto_hdrs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Wh sto hdr was successfully destroyed"
  end
end
