require 'test_helper'

class AdocStatusesControllerTest < ActionController::TestCase
  setup do
    @adoc_status = adoc_statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:adoc_statuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create adoc_status" do
    assert_difference('AdocStatus.count') do
      post :create, adoc_status: { color: @adoc_status.color, name: @adoc_status.name, order: @adoc_status.order }
    end

    assert_redirected_to adoc_status_path(assigns(:adoc_status))
  end

  test "should show adoc_status" do
    get :show, id: @adoc_status
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @adoc_status
    assert_response :success
  end

  test "should update adoc_status" do
    patch :update, id: @adoc_status, adoc_status: { color: @adoc_status.color, name: @adoc_status.name, order: @adoc_status.order }
    assert_redirected_to adoc_status_path(assigns(:adoc_status))
  end

  test "should destroy adoc_status" do
    assert_difference('AdocStatus.count', -1) do
      delete :destroy, id: @adoc_status
    end

    assert_redirected_to adoc_statuses_path
  end
end
