require "application_system_test_case"

class WhIssueHdrsTest < ApplicationSystemTestCase
  setup do
    @wh_issue_hdr = wh_issue_hdrs(:one)
  end

  test "visiting the index" do
    visit wh_issue_hdrs_url
    assert_selector "h1", text: "Wh Issue Hdrs"
  end

  test "creating a Wh issue hdr" do
    visit wh_issue_hdrs_url
    click_on "New Wh Issue Hdr"

    click_on "Create Wh issue hdr"

    assert_text "Wh issue hdr was successfully created"
    click_on "Back"
  end

  test "updating a Wh issue hdr" do
    visit wh_issue_hdrs_url
    click_on "Edit", match: :first

    click_on "Update Wh issue hdr"

    assert_text "Wh issue hdr was successfully updated"
    click_on "Back"
  end

  test "destroying a Wh issue hdr" do
    visit wh_issue_hdrs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Wh issue hdr was successfully destroyed"
  end
end
