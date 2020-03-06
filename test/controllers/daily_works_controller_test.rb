require 'test_helper'

class DailyWorksControllerTest < ActionController::TestCase
  setup do
    @daily_work = daily_works(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:daily_works)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create daily_work" do
    assert_difference('DailyWork.count') do
      post :create, daily_work: { date: @daily_work.date, user_id: @daily_work.user_id }
    end

    assert_redirected_to daily_work_path(assigns(:daily_work))
  end

  test "should show daily_work" do
    get :show, id: @daily_work
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @daily_work
    assert_response :success
  end

  test "should update daily_work" do
    patch :update, id: @daily_work, daily_work: { date: @daily_work.date, user_id: @daily_work.user_id }
    assert_redirected_to daily_work_path(assigns(:daily_work))
  end

  test "should destroy daily_work" do
    assert_difference('DailyWork.count', -1) do
      delete :destroy, id: @daily_work
    end

    assert_redirected_to daily_works_path
  end
end
