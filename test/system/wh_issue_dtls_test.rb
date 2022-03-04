require "application_system_test_case"

class WhIssueDtlsTest < ApplicationSystemTestCase
  setup do
    @wh_issue_dtl = wh_issue_dtls(:one)
  end

  test "visiting the index" do
    visit wh_issue_dtls_url
    assert_selector "h1", text: "Wh Issue Dtls"
  end

  test "creating a Wh issue dtl" do
    visit wh_issue_dtls_url
    click_on "New Wh Issue Dtl"

    click_on "Create Wh issue dtl"

    assert_text "Wh issue dtl was successfully created"
    click_on "Back"
  end

  test "updating a Wh issue dtl" do
    visit wh_issue_dtls_url
    click_on "Edit", match: :first

    click_on "Update Wh issue dtl"

    assert_text "Wh issue dtl was successfully updated"
    click_on "Back"
  end

  test "destroying a Wh issue dtl" do
    visit wh_issue_dtls_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Wh issue dtl was successfully destroyed"
  end
end
