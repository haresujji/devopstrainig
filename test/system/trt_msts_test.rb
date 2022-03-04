require "application_system_test_case"

class TrtMstsTest < ApplicationSystemTestCase
  setup do
    @trt_mst = trt_msts(:one)
  end

  test "visiting the index" do
    visit trt_msts_url
    assert_selector "h1", text: "Trt Msts"
  end

  test "creating a Trt mst" do
    visit trt_msts_url
    click_on "New Trt Mst"

    click_on "Create Trt mst"

    assert_text "Trt mst was successfully created"
    click_on "Back"
  end

  test "updating a Trt mst" do
    visit trt_msts_url
    click_on "Edit", match: :first

    click_on "Update Trt mst"

    assert_text "Trt mst was successfully updated"
    click_on "Back"
  end

  test "destroying a Trt mst" do
    visit trt_msts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Trt mst was successfully destroyed"
  end
end
