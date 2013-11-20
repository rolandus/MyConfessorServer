require 'test_helper'

class ConfessorRequestChangesControllerTest < ActionController::TestCase
  setup do
    @confessor_request_change = confessor_request_changes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:confessor_request_changes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create confessor_request_change" do
    assert_difference('ConfessorRequestChange.count') do
      post :create, confessor_request_change: { ConfessorRequest_id: @confessor_request_change.ConfessorRequest_id, change_comments: @confessor_request_change.change_comments, changed_by_user_id: @confessor_request_change.changed_by_user_id, confessor_request_status_id: @confessor_request_change.confessor_request_status_id, diocese_id: @confessor_request_change.diocese_id, first_name: @confessor_request_change.first_name, last_name: @confessor_request_change.last_name, state_id: @confessor_request_change.state_id }
    end

    assert_redirected_to confessor_request_change_path(assigns(:confessor_request_change))
  end

  test "should show confessor_request_change" do
    get :show, id: @confessor_request_change
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @confessor_request_change
    assert_response :success
  end

  test "should update confessor_request_change" do
    patch :update, id: @confessor_request_change, confessor_request_change: { ConfessorRequest_id: @confessor_request_change.ConfessorRequest_id, change_comments: @confessor_request_change.change_comments, changed_by_user_id: @confessor_request_change.changed_by_user_id, confessor_request_status_id: @confessor_request_change.confessor_request_status_id, diocese_id: @confessor_request_change.diocese_id, first_name: @confessor_request_change.first_name, last_name: @confessor_request_change.last_name, state_id: @confessor_request_change.state_id }
    assert_redirected_to confessor_request_change_path(assigns(:confessor_request_change))
  end

  test "should destroy confessor_request_change" do
    assert_difference('ConfessorRequestChange.count', -1) do
      delete :destroy, id: @confessor_request_change
    end

    assert_redirected_to confessor_request_changes_path
  end
end
