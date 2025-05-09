require "application_system_test_case"

class ExchangeCoinsTest < ApplicationSystemTestCase
  setup do
    @exchange_coin = exchange_coins(:one)
  end

  test "visiting the index" do
    visit exchange_coins_url
    assert_selector "h1", text: "Exchange coins"
  end

  test "should create exchange coin" do
    visit exchange_coins_url
    click_on "New exchange coin"

    fill_in "Coin", with: @exchange_coin.coin_id
    fill_in "Exchange", with: @exchange_coin.exchange_id
    click_on "Create Exchange coin"

    assert_text "Exchange coin was successfully created"
    click_on "Back"
  end

  test "should update Exchange coin" do
    visit exchange_coin_url(@exchange_coin)
    click_on "Edit this exchange coin", match: :first

    fill_in "Coin", with: @exchange_coin.coin_id
    fill_in "Exchange", with: @exchange_coin.exchange_id
    click_on "Update Exchange coin"

    assert_text "Exchange coin was successfully updated"
    click_on "Back"
  end

  test "should destroy Exchange coin" do
    visit exchange_coin_url(@exchange_coin)
    click_on "Destroy this exchange coin", match: :first

    assert_text "Exchange coin was successfully destroyed"
  end
end
