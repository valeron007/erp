require 'test_helper'

class ReportControllerTest < ActionController::TestCase
  test "should get dashboard" do
    get :dashboard
    assert_response :success
  end

  test "should get employee_payments" do
    get :employee_payments
    assert_response :success
  end

  test "should get facility_works" do
    get :facility_works
    assert_response :success
  end

  test "should get labor_costs" do
    get :labor_costs
    assert_response :success
  end

  test "should get work_efficiency" do
    get :work_efficiency
    assert_response :success
  end

end
