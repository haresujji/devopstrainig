require "application_system_test_case"

class TrnWhRequestDtlsTest < ApplicationSystemTestCase
  setup do
    @trn_wh_request_dtl = trn_wh_request_dtls(:one)
  end

  test "visiting the index" do
    visit trn_wh_request_dtls_url
    assert_selector "h1", text: "Trn Wh Request Dtls"
  end

  test "creating a Trn wh request dtl" do
    visit trn_wh_request_dtls_url
    click_on "New Trn Wh Request Dtl"

    click_on "Create Trn wh request dtl"

    assert_text "Trn wh request dtl was successfully created"
    click_on "Back"
  end

  test "updating a Trn wh request dtl" do
    visit trn_wh_request_dtls_url
    click_on "Edit", match: :first

    click_on "Update Trn wh request dtl"

    assert_text "Trn wh request dtl was successfully updated"
    click_on "Back"
  end

  test "destroying a Trn wh request dtl" do
    visit trn_wh_request_dtls_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Trn wh request dtl was successfully destroyed"
  end
end
