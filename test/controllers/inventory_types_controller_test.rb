require 'test_helper'

class InventoryTypesControllerTest < ActionController::TestCase
  setup do
    @inventory_type = inventory_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inventory_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inventory_type" do
    assert_difference('InventoryType.count') do
      post :create, inventory_type: { name: @inventory_type.name }
    end

    assert_redirected_to inventory_type_path(assigns(:inventory_type))
  end

  test "should show inventory_type" do
    get :show, id: @inventory_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @inventory_type
    assert_response :success
  end

  test "should update inventory_type" do
    patch :update, id: @inventory_type, inventory_type: { name: @inventory_type.name }
    assert_redirected_to inventory_type_path(assigns(:inventory_type))
  end

  test "should destroy inventory_type" do
    assert_difference('InventoryType.count', -1) do
      delete :destroy, id: @inventory_type
    end

    assert_redirected_to inventory_types_path
  end
end
