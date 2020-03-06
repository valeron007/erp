require 'test_helper'

class SOthersControllerTest < ActionController::TestCase
  setup do
    @s_other = s_others(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:s_others)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create s_other" do
    assert_difference('SOther.count') do
      post :create, s_other: { amount: @s_other.amount, comments: @s_other.comments, min_amount: @s_other.min_amount, name_id: @s_other.name_id, storage_place: @s_other.storage_place, unit_id: @s_other.unit_id }
    end

    assert_redirected_to s_other_path(assigns(:s_other))
  end

  test "should show s_other" do
    get :show, id: @s_other
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @s_other
    assert_response :success
  end

  test "should update s_other" do
    patch :update, id: @s_other, s_other: { amount: @s_other.amount, comments: @s_other.comments, min_amount: @s_other.min_amount, name_id: @s_other.name_id, storage_place: @s_other.storage_place, unit_id: @s_other.unit_id }
    assert_redirected_to s_other_path(assigns(:s_other))
  end

  test "should destroy s_other" do
    assert_difference('SOther.count', -1) do
      delete :destroy, id: @s_other
    end

    assert_redirected_to s_others_path
  end
end
