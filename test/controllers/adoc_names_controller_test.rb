require 'test_helper'

class AdocNamesControllerTest < ActionController::TestCase
  setup do
    @adoc_name = adoc_names(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:adoc_names)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create adoc_name" do
    assert_difference('AdocName.count') do
      post :create, adoc_name: { name: @adoc_name.name }
    end

    assert_redirected_to adoc_name_path(assigns(:adoc_name))
  end

  test "should show adoc_name" do
    get :show, id: @adoc_name
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @adoc_name
    assert_response :success
  end

  test "should update adoc_name" do
    patch :update, id: @adoc_name, adoc_name: { name: @adoc_name.name }
    assert_redirected_to adoc_name_path(assigns(:adoc_name))
  end

  test "should destroy adoc_name" do
    assert_difference('AdocName.count', -1) do
      delete :destroy, id: @adoc_name
    end

    assert_redirected_to adoc_names_path
  end
end
