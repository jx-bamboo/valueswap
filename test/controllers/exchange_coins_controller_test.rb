require "test_helper"

class ExchangeCoinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @exchange_coin = exchange_coins(:one)
  end

  test "should get index" do
    get exchange_coins_url
    assert_response :success
  end

  test "should get new" do
    get new_exchange_coin_url
    assert_response :success
  end

  test "should create exchange_coin" do
    assert_difference("ExchangeCoin.count") do
      post exchange_coins_url, params: { exchange_coin: { coin_id: @exchange_coin.coin_id, exchange_id: @exchange_coin.exchange_id } }
    end

    assert_redirected_to exchange_coin_url(ExchangeCoin.last)
  end

  test "should show exchange_coin" do
    get exchange_coin_url(@exchange_coin)
    assert_response :success
  end

  test "should get edit" do
    get edit_exchange_coin_url(@exchange_coin)
    assert_response :success
  end

  test "should update exchange_coin" do
    patch exchange_coin_url(@exchange_coin), params: { exchange_coin: { coin_id: @exchange_coin.coin_id, exchange_id: @exchange_coin.exchange_id } }
    assert_redirected_to exchange_coin_url(@exchange_coin)
  end

  test "should destroy exchange_coin" do
    assert_difference("ExchangeCoin.count", -1) do
      delete exchange_coin_url(@exchange_coin)
    end

    assert_redirected_to exchange_coins_url
  end
end
