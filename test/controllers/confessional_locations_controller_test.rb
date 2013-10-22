require 'test_helper'

class ConfessionalLocationsControllerTest < ActionController::TestCase
  setup do
    @confessional_location = confessional_locations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:confessional_locations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create confessional_location" do
    assert_difference('ConfessionalLocation.count') do
      post :create, confessional_location: { city: @confessional_location.city, name: @confessional_location.name, nickname: @confessional_location.nickname, state: @confessional_location.state, street_address: @confessional_location.street_address }
    end

    assert_redirected_to confessional_location_path(assigns(:confessional_location))
  end

  test "should show confessional_location" do
    get :show, id: @confessional_location
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @confessional_location
    assert_response :success
  end

  test "should update confessional_location" do
    patch :update, id: @confessional_location, confessional_location: { city: @confessional_location.city, name: @confessional_location.name, nickname: @confessional_location.nickname, state: @confessional_location.state, street_address: @confessional_location.street_address }
    assert_redirected_to confessional_location_path(assigns(:confessional_location))
  end

  test "should destroy confessional_location" do
    assert_difference('ConfessionalLocation.count', -1) do
      delete :destroy, id: @confessional_location
    end

    assert_redirected_to confessional_locations_path
  end
end
