require 'test_helper'

class DailyTimesheetsControllerTest < ActionController::TestCase
  setup do
    @daily_timesheet = daily_timesheets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:daily_timesheets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create daily_timesheet" do
    assert_difference('DailyTimesheet.count') do
      post :create, daily_timesheet: { date: @daily_timesheet.date, description: @daily_timesheet.description, employee_id: @daily_timesheet.employee_id, end_time: @daily_timesheet.end_time, facility_id: @daily_timesheet.facility_id, overtime: @daily_timesheet.overtime, payment_type_id: @daily_timesheet.payment_type_id, penalty_description: @daily_timesheet.penalty_description, penalty_id: @daily_timesheet.penalty_id, probation_period: @daily_timesheet.probation_period, quality_penalty_id: @daily_timesheet.quality_penalty_id, ratio: @daily_timesheet.ratio, rework: @daily_timesheet.rework, salary: @daily_timesheet.salary, salary_period_id: @daily_timesheet.salary_period_id, start_time: @daily_timesheet.start_time, total_amount: @daily_timesheet.total_amount, work_type_id: @daily_timesheet.work_type_id }
    end

    assert_redirected_to daily_timesheet_path(assigns(:daily_timesheet))
  end

  test "should show daily_timesheet" do
    get :show, id: @daily_timesheet
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @daily_timesheet
    assert_response :success
  end

  test "should update daily_timesheet" do
    patch :update, id: @daily_timesheet, daily_timesheet: { date: @daily_timesheet.date, description: @daily_timesheet.description, employee_id: @daily_timesheet.employee_id, end_time: @daily_timesheet.end_time, facility_id: @daily_timesheet.facility_id, overtime: @daily_timesheet.overtime, payment_type_id: @daily_timesheet.payment_type_id, penalty_description: @daily_timesheet.penalty_description, penalty_id: @daily_timesheet.penalty_id, probation_period: @daily_timesheet.probation_period, quality_penalty_id: @daily_timesheet.quality_penalty_id, ratio: @daily_timesheet.ratio, rework: @daily_timesheet.rework, salary: @daily_timesheet.salary, salary_period_id: @daily_timesheet.salary_period_id, start_time: @daily_timesheet.start_time, total_amount: @daily_timesheet.total_amount, work_type_id: @daily_timesheet.work_type_id }
    assert_redirected_to daily_timesheet_path(assigns(:daily_timesheet))
  end

  test "should destroy daily_timesheet" do
    assert_difference('DailyTimesheet.count', -1) do
      delete :destroy, id: @daily_timesheet
    end

    assert_redirected_to daily_timesheets_path
  end
end
