require "application_system_test_case"

class TrnWhIssueDtlsTest < ApplicationSystemTestCase
  setup do
    @trn_wh_issue_dtl = trn_wh_issue_dtls(:one)
  end

  test "visiting the index" do
    visit trn_wh_issue_dtls_url
    assert_selector "h1", text: "Trn Wh Issue Dtls"
  end

  test "creating a Trn wh issue dtl" do
    visit trn_wh_issue_dtls_url
    click_on "New Trn Wh Issue Dtl"

    click_on "Create Trn wh issue dtl"

    assert_text "Trn wh issue dtl was successfully created"
    click_on "Back"
  end

  test "updating a Trn wh issue dtl" do
    visit trn_wh_issue_dtls_url
    click_on "Edit", match: :first

    click_on "Update Trn wh issue dtl"

    assert_text "Trn wh issue dtl was successfully updated"
    click_on "Back"
  end

  test "destroying a Trn wh issue dtl" do
    visit trn_wh_issue_dtls_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Trn wh issue dtl was successfully destroyed"
  end
end
