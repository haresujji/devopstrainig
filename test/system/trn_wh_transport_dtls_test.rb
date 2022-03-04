require "application_system_test_case"

class TrnWhTransportDtlsTest < ApplicationSystemTestCase
  setup do
    @trn_wh_transport_dtl = trn_wh_transport_dtls(:one)
  end

  test "visiting the index" do
    visit trn_wh_transport_dtls_url
    assert_selector "h1", text: "Trn Wh Transport Dtls"
  end

  test "creating a Trn wh transport dtl" do
    visit trn_wh_transport_dtls_url
    click_on "New Trn Wh Transport Dtl"

    click_on "Create Trn wh transport dtl"

    assert_text "Trn wh transport dtl was successfully created"
    click_on "Back"
  end

  test "updating a Trn wh transport dtl" do
    visit trn_wh_transport_dtls_url
    click_on "Edit", match: :first

    click_on "Update Trn wh transport dtl"

    assert_text "Trn wh transport dtl was successfully updated"
    click_on "Back"
  end

  test "destroying a Trn wh transport dtl" do
    visit trn_wh_transport_dtls_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Trn wh transport dtl was successfully destroyed"
  end
end
