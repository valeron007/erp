require 'test_helper'

class SAdditionalsControllerTest < ActionController::TestCase
  setup do
    @s_additional = s_additionals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:s_additionals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create s_additional" do
    assert_difference('SAdditional.count') do
      post :create, s_additional: { additional_id: @s_additional.additional_id, amount: @s_additional.amount, comments: @s_additional.comments, min_amount: @s_additional.min_amount, s_additional_files: @s_additional.s_additional_files, storage_place: @s_additional.storage_place, unit_id: @s_additional.unit_id }
    end

    assert_redirected_to s_additional_path(assigns(:s_additional))
  end

  test "should show s_additional" do
    get :show, id: @s_additional
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @s_additional
    assert_response :success
  end

  test "should update s_additional" do
    patch :update, id: @s_additional, s_additional: { additional_id: @s_additional.additional_id, amount: @s_additional.amount, comments: @s_additional.comments, min_amount: @s_additional.min_amount, s_additional_files: @s_additional.s_additional_files, storage_place: @s_additional.storage_place, unit_id: @s_additional.unit_id }
    assert_redirected_to s_additional_path(assigns(:s_additional))
  end

  test "should destroy s_additional" do
    assert_difference('SAdditional.count', -1) do
      delete :destroy, id: @s_additional
    end

    assert_redirected_to s_additionals_path
  end
end
