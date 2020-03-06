require 'test_helper'

class SMaterialsControllerTest < ActionController::TestCase
  setup do
    @s_material = s_materials(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:s_materials)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create s_material" do
    assert_difference('SMaterial.count') do
      post :create, s_material: { amount: @s_material.amount, comments: @s_material.comments, min_amount: @s_material.min_amount, name_id: @s_material.name_id, pack: @s_material.pack, storage_place: @s_material.storage_place, unit_id: @s_material.unit_id }
    end

    assert_redirected_to s_material_path(assigns(:s_material))
  end

  test "should show s_material" do
    get :show, id: @s_material
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @s_material
    assert_response :success
  end

  test "should update s_material" do
    patch :update, id: @s_material, s_material: { amount: @s_material.amount, comments: @s_material.comments, min_amount: @s_material.min_amount, name_id: @s_material.name_id, pack: @s_material.pack, storage_place: @s_material.storage_place, unit_id: @s_material.unit_id }
    assert_redirected_to s_material_path(assigns(:s_material))
  end

  test "should destroy s_material" do
    assert_difference('SMaterial.count', -1) do
      delete :destroy, id: @s_material
    end

    assert_redirected_to s_materials_path
  end
end
