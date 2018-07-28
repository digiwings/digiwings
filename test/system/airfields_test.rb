require "application_system_test_case"

class AirfieldsTest < ApplicationSystemTestCase
  setup do
    @airfield = airfields(:one)
  end

  test "visiting the index" do
    visit airfields_url
    assert_selector "h1", text: "Airfields"
  end

  test "creating a Airfield" do
    visit airfields_url
    click_on "New Airfield"

    fill_in "City", with: @airfield.city
    fill_in "Elevation", with: @airfield.elevation
    fill_in "Iata", with: @airfield.iata
    fill_in "Icao", with: @airfield.icao
    fill_in "Lat", with: @airfield.lat
    fill_in "Lon", with: @airfield.lon
    fill_in "Name", with: @airfield.name
    fill_in "State", with: @airfield.state
    click_on "Create Airfield"

    assert_text "Airfield was successfully created"
    click_on "Back"
  end

  test "updating a Airfield" do
    visit airfields_url
    click_on "Edit", match: :first

    fill_in "City", with: @airfield.city
    fill_in "Elevation", with: @airfield.elevation
    fill_in "Iata", with: @airfield.iata
    fill_in "Icao", with: @airfield.icao
    fill_in "Lat", with: @airfield.lat
    fill_in "Lon", with: @airfield.lon
    fill_in "Name", with: @airfield.name
    fill_in "State", with: @airfield.state
    click_on "Update Airfield"

    assert_text "Airfield was successfully updated"
    click_on "Back"
  end

  test "destroying a Airfield" do
    visit airfields_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Airfield was successfully destroyed"
  end
end
