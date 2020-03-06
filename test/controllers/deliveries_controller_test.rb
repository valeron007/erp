require 'test_helper'

class DeliveriesControllerTest < ActionController::TestCase
  setup do
    @delivery = deliveries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:deliveries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create delivery" do
    assert_difference('Delivery.count') do
      post :create, delivery: { address: @delivery.address, arrival_date: @delivery.arrival_date, city: @delivery.city, commodity_type_id: @delivery.commodity_type_id, contractor_id: @delivery.contractor_id, cost: @delivery.cost, count: @delivery.count, delivery_cost: @delivery.delivery_cost, delivery_dest_id: @delivery.delivery_dest_id, delivery_document_id: @delivery.delivery_document_id, delivery_letter: @delivery.delivery_letter, delivery_payment_status_id: @delivery.delivery_payment_status_id, delivery_perunit: @delivery.delivery_perunit, delivery_status_id: @delivery.delivery_status_id, dispatch_date: @delivery.dispatch_date, name: @delivery.name, order_date: @delivery.order_date, pack: @delivery.pack, total_with_delivery: @delivery.total_with_delivery, transport_company_id: @delivery.transport_company_id, unit_id: @delivery.unit_id, vat: @delivery.vat, volume: @delivery.volume, volume_unit_id: @delivery.volume_unit_id }
    end

    assert_redirected_to delivery_path(assigns(:delivery))
  end

  test "should show delivery" do
    get :show, id: @delivery
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @delivery
    assert_response :success
  end

  test "should update delivery" do
    patch :update, id: @delivery, delivery: { address: @delivery.address, arrival_date: @delivery.arrival_date, city: @delivery.city, commodity_type_id: @delivery.commodity_type_id, contractor_id: @delivery.contractor_id, cost: @delivery.cost, count: @delivery.count, delivery_cost: @delivery.delivery_cost, delivery_dest_id: @delivery.delivery_dest_id, delivery_document_id: @delivery.delivery_document_id, delivery_letter: @delivery.delivery_letter, delivery_payment_status_id: @delivery.delivery_payment_status_id, delivery_perunit: @delivery.delivery_perunit, delivery_status_id: @delivery.delivery_status_id, dispatch_date: @delivery.dispatch_date, name: @delivery.name, order_date: @delivery.order_date, pack: @delivery.pack, total_with_delivery: @delivery.total_with_delivery, transport_company_id: @delivery.transport_company_id, unit_id: @delivery.unit_id, vat: @delivery.vat, volume: @delivery.volume, volume_unit_id: @delivery.volume_unit_id }
    assert_redirected_to delivery_path(assigns(:delivery))
  end

  test "should destroy delivery" do
    assert_difference('Delivery.count', -1) do
      delete :destroy, id: @delivery
    end

    assert_redirected_to deliveries_path
  end
end
