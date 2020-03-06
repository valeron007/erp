require 'test_helper'

class OthersControllerTest < ActionController::TestCase
  setup do
    @other = others(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:others)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create other" do
    assert_difference('Other.count') do
      post :create, other: { name: @other.name }
    end

    assert_redirected_to other_path(assigns(:other))
  end

  test "should show other" do
    get :show, id: @other
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @other
    assert_response :success
  end

  test "should update other" do
    patch :update, id: @other, other: { name: @other.name }
    assert_redirected_to other_path(assigns(:other))
  end

  test "should destroy other" do
    assert_difference('Other.count', -1) do
      delete :destroy, id: @other
    end

    assert_redirected_to others_path
  end
end
