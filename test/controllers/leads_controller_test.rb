require 'test_helper'

class LeadsControllerTest < ActionController::TestCase
  setup do
    @lead = leads(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:leads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lead" do
    assert_difference('Lead.count') do
      post :create, lead: { address: @lead.address, client_id: @lead.client_id, credit: @lead.credit, debt: @lead.debt, details: @lead.details, gap: @lead.gap, gap_phone: @lead.gap_phone, gip: @lead.gip, gip_phone: @lead.gip_phone, lead_construction_type_id: @lead.lead_construction_type_id, lead_payment_status_id: @lead.lead_payment_status_id, lead_status_id: @lead.lead_status_id, lead_type_id: @lead.lead_type_id, name: @lead.name, next_date: @lead.next_date, project: @lead.project, project_help: @lead.project_help, project_institute: @lead.project_institute, psycho01: @lead.psycho01, psycho02: @lead.psycho02, psycho03: @lead.psycho03, psycho04: @lead.psycho04, psycho05: @lead.psycho05, psycho06: @lead.psycho06, psycho07: @lead.psycho07, psycho08: @lead.psycho08, psycho09: @lead.psycho09, psycho10: @lead.psycho10, psycho11: @lead.psycho11, psycho12: @lead.psycho12, psycho13: @lead.psycho13, psycho_other: @lead.psycho_other, representatives: @lead.representatives, short_name: @lead.short_name, sum_contract: @lead.sum_contract, sum_payment: @lead.sum_payment, visit_date: @lead.visit_date }
    end

    assert_redirected_to lead_path(assigns(:lead))
  end

  test "should show lead" do
    get :show, id: @lead
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lead
    assert_response :success
  end

  test "should update lead" do
    patch :update, id: @lead, lead: { address: @lead.address, client_id: @lead.client_id, credit: @lead.credit, debt: @lead.debt, details: @lead.details, gap: @lead.gap, gap_phone: @lead.gap_phone, gip: @lead.gip, gip_phone: @lead.gip_phone, lead_construction_type_id: @lead.lead_construction_type_id, lead_payment_status_id: @lead.lead_payment_status_id, lead_status_id: @lead.lead_status_id, lead_type_id: @lead.lead_type_id, name: @lead.name, next_date: @lead.next_date, project: @lead.project, project_help: @lead.project_help, project_institute: @lead.project_institute, psycho01: @lead.psycho01, psycho02: @lead.psycho02, psycho03: @lead.psycho03, psycho04: @lead.psycho04, psycho05: @lead.psycho05, psycho06: @lead.psycho06, psycho07: @lead.psycho07, psycho08: @lead.psycho08, psycho09: @lead.psycho09, psycho10: @lead.psycho10, psycho11: @lead.psycho11, psycho12: @lead.psycho12, psycho13: @lead.psycho13, psycho_other: @lead.psycho_other, representatives: @lead.representatives, short_name: @lead.short_name, sum_contract: @lead.sum_contract, sum_payment: @lead.sum_payment, visit_date: @lead.visit_date }
    assert_redirected_to lead_path(assigns(:lead))
  end

  test "should destroy lead" do
    assert_difference('Lead.count', -1) do
      delete :destroy, id: @lead
    end

    assert_redirected_to leads_path
  end
end
