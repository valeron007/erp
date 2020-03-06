require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  setup do
    @task = tasks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tasks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create task" do
    assert_difference('Task.count') do
      post :create, task: { assign_date: @task.assign_date, assigned_by_id: @task.assigned_by_id, assigned_to_id: @task.assigned_to_id, created_by_id: @task.created_by_id, desc: @task.desc, finish_date: @task.finish_date, task_status_id: @task.task_status_id, title: @task.title, updated_by_id: @task.updated_by_id }
    end

    assert_redirected_to task_path(assigns(:task))
  end

  test "should show task" do
    get :show, id: @task
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @task
    assert_response :success
  end

  test "should update task" do
    patch :update, id: @task, task: { assign_date: @task.assign_date, assigned_by_id: @task.assigned_by_id, assigned_to_id: @task.assigned_to_id, created_by_id: @task.created_by_id, desc: @task.desc, finish_date: @task.finish_date, task_status_id: @task.task_status_id, title: @task.title, updated_by_id: @task.updated_by_id }
    assert_redirected_to task_path(assigns(:task))
  end

  test "should destroy task" do
    assert_difference('Task.count', -1) do
      delete :destroy, id: @task
    end

    assert_redirected_to tasks_path
  end
end
