require "application_system_test_case"

class TrnWhIssueHdrsTest < ApplicationSystemTestCase
  setup do
    @trn_wh_issue_hdr = trn_wh_issue_hdrs(:one)
  end

  test "visiting the index" do
    visit trn_wh_issue_hdrs_url
    assert_selector "h1", text: "Trn Wh Issue Hdrs"
  end

  test "creating a Trn wh issue hdr" do
    visit trn_wh_issue_hdrs_url
    click_on "New Trn Wh Issue Hdr"

    click_on "Create Trn wh issue hdr"

    assert_text "Trn wh issue hdr was successfully created"
    click_on "Back"
  end

  test "updating a Trn wh issue hdr" do
    visit trn_wh_issue_hdrs_url
    click_on "Edit", match: :first

    click_on "Update Trn wh issue hdr"

    assert_text "Trn wh issue hdr was successfully updated"
    click_on "Back"
  end

  test "destroying a Trn wh issue hdr" do
    visit trn_wh_issue_hdrs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Trn wh issue hdr was successfully destroyed"
  end
end
