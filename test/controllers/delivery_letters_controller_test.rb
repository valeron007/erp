require 'test_helper'

class DeliveryLettersControllerTest < ActionController::TestCase
  setup do
    @delivery_letter = delivery_letters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:delivery_letters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create delivery_letter" do
    assert_difference('DeliveryLetter.count') do
      post :create, delivery_letter: { name: @delivery_letter.name }
    end

    assert_redirected_to delivery_letter_path(assigns(:delivery_letter))
  end

  test "should show delivery_letter" do
    get :show, id: @delivery_letter
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @delivery_letter
    assert_response :success
  end

  test "should update delivery_letter" do
    patch :update, id: @delivery_letter, delivery_letter: { name: @delivery_letter.name }
    assert_redirected_to delivery_letter_path(assigns(:delivery_letter))
  end

  test "should destroy delivery_letter" do
    assert_difference('DeliveryLetter.count', -1) do
      delete :destroy, id: @delivery_letter
    end

    assert_redirected_to delivery_letters_path
  end
end
