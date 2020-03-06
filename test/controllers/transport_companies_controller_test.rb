require 'test_helper'

class TransportCompaniesControllerTest < ActionController::TestCase
  setup do
    @transport_company = transport_companies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:transport_companies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create transport_company" do
    assert_difference('TransportCompany.count') do
      post :create, transport_company: { name: @transport_company.name }
    end

    assert_redirected_to transport_company_path(assigns(:transport_company))
  end

  test "should show transport_company" do
    get :show, id: @transport_company
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @transport_company
    assert_response :success
  end

  test "should update transport_company" do
    patch :update, id: @transport_company, transport_company: { name: @transport_company.name }
    assert_redirected_to transport_company_path(assigns(:transport_company))
  end

  test "should destroy transport_company" do
    assert_difference('TransportCompany.count', -1) do
      delete :destroy, id: @transport_company
    end

    assert_redirected_to transport_companies_path
  end
end
