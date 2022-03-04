require "application_system_test_case"

class WhMaterialStoragesTest < ApplicationSystemTestCase
  setup do
    @wh_material_storage = wh_material_storages(:one)
  end

  test "visiting the index" do
    visit wh_material_storages_url
    assert_selector "h1", text: "Wh Material Storages"
  end

  test "creating a Wh material storage" do
    visit wh_material_storages_url
    click_on "New Wh Material Storage"

    click_on "Create Wh material storage"

    assert_text "Wh material storage was successfully created"
    click_on "Back"
  end

  test "updating a Wh material storage" do
    visit wh_material_storages_url
    click_on "Edit", match: :first

    click_on "Update Wh material storage"

    assert_text "Wh material storage was successfully updated"
    click_on "Back"
  end

  test "destroying a Wh material storage" do
    visit wh_material_storages_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Wh material storage was successfully destroyed"
  end
end
