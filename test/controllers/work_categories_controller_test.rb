require 'test_helper'

class WorkCategoriesControllerTest < ActionController::TestCase
  setup do
    @work_category = work_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:work_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create work_category" do
    assert_difference('WorkCategory.count') do
      post :create, work_category: { name: @work_category.name }
    end

    assert_redirected_to work_category_path(assigns(:work_category))
  end

  test "should show work_category" do
    get :show, id: @work_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @work_category
    assert_response :success
  end

  test "should update work_category" do
    patch :update, id: @work_category, work_category: { name: @work_category.name }
    assert_redirected_to work_category_path(assigns(:work_category))
  end

  test "should destroy work_category" do
    assert_difference('WorkCategory.count', -1) do
      delete :destroy, id: @work_category
    end

    assert_redirected_to work_categories_path
  end
end
