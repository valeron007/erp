require 'test_helper'

class KpisControllerTest < ActionController::TestCase
  setup do
    @kpi = kpis(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:kpis)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create kpi" do
    assert_difference('Kpi.count') do
      post :create, kpi: { name: @kpi.name, norm: @kpi.norm, weight: @kpi.weight }
    end

    assert_redirected_to kpi_path(assigns(:kpi))
  end

  test "should show kpi" do
    get :show, id: @kpi
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @kpi
    assert_response :success
  end

  test "should update kpi" do
    patch :update, id: @kpi, kpi: { name: @kpi.name, norm: @kpi.norm, weight: @kpi.weight }
    assert_redirected_to kpi_path(assigns(:kpi))
  end

  test "should destroy kpi" do
    assert_difference('Kpi.count', -1) do
      delete :destroy, id: @kpi
    end

    assert_redirected_to kpis_path
  end
end
