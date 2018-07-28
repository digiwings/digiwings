require 'test_helper'

class AirfieldsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @airfield = airfields(:one)
  end

  test "should get index" do
    get airfields_url
    assert_response :success
  end

  test "should get new" do
    get new_airfield_url
    assert_response :success
  end

  test "should create airfield" do
    assert_difference('Airfield.count') do
      post airfields_url, params: { airfield: { city: @airfield.city, elevation: @airfield.elevation, iata: @airfield.iata, icao: @airfield.icao, lat: @airfield.lat, lon: @airfield.lon, name: @airfield.name, state: @airfield.state } }
    end

    assert_redirected_to airfield_url(Airfield.last)
  end

  test "should show airfield" do
    get airfield_url(@airfield)
    assert_response :success
  end

  test "should get edit" do
    get edit_airfield_url(@airfield)
    assert_response :success
  end

  test "should update airfield" do
    patch airfield_url(@airfield), params: { airfield: { city: @airfield.city, elevation: @airfield.elevation, iata: @airfield.iata, icao: @airfield.icao, lat: @airfield.lat, lon: @airfield.lon, name: @airfield.name, state: @airfield.state } }
    assert_redirected_to airfield_url(@airfield)
  end

  test "should destroy airfield" do
    assert_difference('Airfield.count', -1) do
      delete airfield_url(@airfield)
    end

    assert_redirected_to airfields_url
  end
end
