require 'test_helper'

class STransactionsControllerTest < ActionController::TestCase
  setup do
    @s_transaction = s_transactions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:s_transactions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create s_transaction" do
    assert_difference('STransaction.count') do
      post :create, s_transaction: { comments: @s_transaction.comments, date: @s_transaction.date, destination_id: @s_transaction.destination_id, user_from_id: @s_transaction.user_from_id, user_to_id: @s_transaction.user_to_id }
    end

    assert_redirected_to s_transaction_path(assigns(:s_transaction))
  end

  test "should show s_transaction" do
    get :show, id: @s_transaction
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @s_transaction
    assert_response :success
  end

  test "should update s_transaction" do
    patch :update, id: @s_transaction, s_transaction: { comments: @s_transaction.comments, date: @s_transaction.date, destination_id: @s_transaction.destination_id, user_from_id: @s_transaction.user_from_id, user_to_id: @s_transaction.user_to_id }
    assert_redirected_to s_transaction_path(assigns(:s_transaction))
  end

  test "should destroy s_transaction" do
    assert_difference('STransaction.count', -1) do
      delete :destroy, id: @s_transaction
    end

    assert_redirected_to s_transactions_path
  end
end
