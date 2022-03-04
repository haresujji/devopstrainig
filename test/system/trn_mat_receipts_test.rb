require "application_system_test_case"

class TrnMatReceiptsTest < ApplicationSystemTestCase
  setup do
    @trn_mat_receipt = trn_mat_receipts(:one)
  end

  test "visiting the index" do
    visit trn_mat_receipts_url
    assert_selector "h1", text: "Trn Mat Receipts"
  end

  test "creating a Trn mat receipt" do
    visit trn_mat_receipts_url
    click_on "New Trn Mat Receipt"

    click_on "Create Trn mat receipt"

    assert_text "Trn mat receipt was successfully created"
    click_on "Back"
  end

  test "updating a Trn mat receipt" do
    visit trn_mat_receipts_url
    click_on "Edit", match: :first

    click_on "Update Trn mat receipt"

    assert_text "Trn mat receipt was successfully updated"
    click_on "Back"
  end

  test "destroying a Trn mat receipt" do
    visit trn_mat_receipts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Trn mat receipt was successfully destroyed"
  end
end
