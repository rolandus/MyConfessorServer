require 'test_helper'

class ConfessorRequestsControllerTest < ActionController::TestCase
  setup do
    @confessor_request = confessor_requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:confessor_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create confessor_request" do
    assert_difference('ConfessorRequest.count') do
      post :create, confessor_request: { confessor_request_status_id: @confessor_request.confessor_request_status_id, diocese_id: @confessor_request.diocese_id, first_name: @confessor_request.first_name, last_name: @confessor_request.last_name, reviewer_comments: @confessor_request.reviewer_comments, reviewer_id: @confessor_request.reviewer_id, state_id: @confessor_request.state_id }
    end

    assert_redirected_to confessor_request_path(assigns(:confessor_request))
  end

  test "should show confessor_request" do
    get :show, id: @confessor_request
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @confessor_request
    assert_response :success
  end

  test "should update confessor_request" do
    patch :update, id: @confessor_request, confessor_request: { confessor_request_status_id: @confessor_request.confessor_request_status_id, diocese_id: @confessor_request.diocese_id, first_name: @confessor_request.first_name, last_name: @confessor_request.last_name, reviewer_comments: @confessor_request.reviewer_comments, reviewer_id: @confessor_request.reviewer_id, state_id: @confessor_request.state_id }
    assert_redirected_to confessor_request_path(assigns(:confessor_request))
  end

  test "should destroy confessor_request" do
    assert_difference('ConfessorRequest.count', -1) do
      delete :destroy, id: @confessor_request
    end

    assert_redirected_to confessor_requests_path
  end
end
