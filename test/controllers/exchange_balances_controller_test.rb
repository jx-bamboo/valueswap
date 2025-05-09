require "test_helper"

class ExchangeBalancesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @exchange_balance = exchange_balances(:one)
  end

  test "should get index" do
    get exchange_balances_url
    assert_response :success
  end

  test "should get new" do
    get new_exchange_balance_url
    assert_response :success
  end

  test "should create exchange_balance" do
    assert_difference("ExchangeBalance.count") do
      post exchange_balances_url, params: { exchange_balance: {} }
    end

    assert_redirected_to exchange_balance_url(ExchangeBalance.last)
  end

  test "should show exchange_balance" do
    get exchange_balance_url(@exchange_balance)
    assert_response :success
  end

  test "should get edit" do
    get edit_exchange_balance_url(@exchange_balance)
    assert_response :success
  end

  test "should update exchange_balance" do
    patch exchange_balance_url(@exchange_balance), params: { exchange_balance: {} }
    assert_redirected_to exchange_balance_url(@exchange_balance)
  end

  test "should destroy exchange_balance" do
    assert_difference("ExchangeBalance.count", -1) do
      delete exchange_balance_url(@exchange_balance)
    end

    assert_redirected_to exchange_balances_url
  end
end
