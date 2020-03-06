require 'test_helper'

class EmployeesControllerTest < ActionController::TestCase
  setup do
    @employee = employees(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:employees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create employee" do
    assert_difference('Employee.count') do
      post :create, employee: { address: @employee.address, birth_date: @employee.birth_date, card_number: @employee.card_number, card_owner: @employee.card_owner, children_count: @employee.children_count, citizenship: @employee.citizenship, dress_size: @employee.dress_size, emergency_name: @employee.emergency_name, emergency_phone: @employee.emergency_phone, employee_status_id: @employee.employee_status_id, felony: @employee.felony, felony_notes: @employee.felony_notes, fire_date: @employee.fire_date, fire_reason_id: @employee.fire_reason_id, first_name: @employee.first_name, height: @employee.height, hire_date: @employee.hire_date, last_name: @employee.last_name, middle_name: @employee.middle_name, mobile_number: @employee.mobile_number, nationality: @employee.nationality, passport: @employee.passport, phone_number: @employee.phone_number, position_id: @employee.position_id, probation_period: @employee.probation_period, residential_address: @employee.residential_address, salary: @employee.salary, salary_ratio: @employee.salary_ratio, shoes_size: @employee.shoes_size }
    end

    assert_redirected_to employee_path(assigns(:employee))
  end

  test "should show employee" do
    get :show, id: @employee
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @employee
    assert_response :success
  end

  test "should update employee" do
    patch :update, id: @employee, employee: { address: @employee.address, birth_date: @employee.birth_date, card_number: @employee.card_number, card_owner: @employee.card_owner, children_count: @employee.children_count, citizenship: @employee.citizenship, dress_size: @employee.dress_size, emergency_name: @employee.emergency_name, emergency_phone: @employee.emergency_phone, employee_status_id: @employee.employee_status_id, felony: @employee.felony, felony_notes: @employee.felony_notes, fire_date: @employee.fire_date, fire_reason_id: @employee.fire_reason_id, first_name: @employee.first_name, height: @employee.height, hire_date: @employee.hire_date, last_name: @employee.last_name, middle_name: @employee.middle_name, mobile_number: @employee.mobile_number, nationality: @employee.nationality, passport: @employee.passport, phone_number: @employee.phone_number, position_id: @employee.position_id, probation_period: @employee.probation_period, residential_address: @employee.residential_address, salary: @employee.salary, salary_ratio: @employee.salary_ratio, shoes_size: @employee.shoes_size }
    assert_redirected_to employee_path(assigns(:employee))
  end

  test "should destroy employee" do
    assert_difference('Employee.count', -1) do
      delete :destroy, id: @employee
    end

    assert_redirected_to employees_path
  end
end
