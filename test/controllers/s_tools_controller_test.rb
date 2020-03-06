require 'test_helper'

class SToolsControllerTest < ActionController::TestCase
  setup do
    @s_tool = s_tools(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:s_tools)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create s_tool" do
    assert_difference('STool.count') do
      post :create, s_tool: { amount: @s_tool.amount, barcode_tag: @s_tool.barcode_tag, comments: @s_tool.comments, consist: @s_tool.consist, description: @s_tool.description, description: @s_tool.description, min_amount: @s_tool.min_amount, name_id: @s_tool.name_id, rfid_tag: @s_tool.rfid_tag, serial_number: @s_tool.serial_number, state: @s_tool.state, storage_place: @s_tool.storage_place }
    end

    assert_redirected_to s_tool_path(assigns(:s_tool))
  end

  test "should show s_tool" do
    get :show, id: @s_tool
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @s_tool
    assert_response :success
  end

  test "should update s_tool" do
    patch :update, id: @s_tool, s_tool: { amount: @s_tool.amount, barcode_tag: @s_tool.barcode_tag, comments: @s_tool.comments, consist: @s_tool.consist, description: @s_tool.description, description: @s_tool.description, min_amount: @s_tool.min_amount, name_id: @s_tool.name_id, rfid_tag: @s_tool.rfid_tag, serial_number: @s_tool.serial_number, state: @s_tool.state, storage_place: @s_tool.storage_place }
    assert_redirected_to s_tool_path(assigns(:s_tool))
  end

  test "should destroy s_tool" do
    assert_difference('STool.count', -1) do
      delete :destroy, id: @s_tool
    end

    assert_redirected_to s_tools_path
  end
end
