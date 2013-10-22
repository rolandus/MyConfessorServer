require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { about_me: @user.about_me, account_status: @user.account_status, city: @user.city, confessional_date: @user.confessional_date, confessional_details: @user.confessional_details, confessional_end_time: @user.confessional_end_time, confessional_location: @user.confessional_location, confessional_start_time: @user.confessional_start_time, confessional_status: @user.confessional_status, diocese: @user.diocese, email: @user.email, first_name: @user.first_name, home_phone: @user.home_phone, last_name: @user.last_name, mobile_phone: @user.mobile_phone, office: @user.office, parish: @user.parish, password: @user.password, photo: @user.photo, salutation: @user.salutation, state: @user.state, street_address: @user.street_address }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { about_me: @user.about_me, account_status: @user.account_status, city: @user.city, confessional_date: @user.confessional_date, confessional_details: @user.confessional_details, confessional_end_time: @user.confessional_end_time, confessional_location: @user.confessional_location, confessional_start_time: @user.confessional_start_time, confessional_status: @user.confessional_status, diocese: @user.diocese, email: @user.email, first_name: @user.first_name, home_phone: @user.home_phone, last_name: @user.last_name, mobile_phone: @user.mobile_phone, office: @user.office, parish: @user.parish, password: @user.password, photo: @user.photo, salutation: @user.salutation, state: @user.state, street_address: @user.street_address }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
