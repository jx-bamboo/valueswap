require "application_system_test_case"

class ExchangeBalancesTest < ApplicationSystemTestCase
  setup do
    @exchange_balance = exchange_balances(:one)
  end

  test "visiting the index" do
    visit exchange_balances_url
    assert_selector "h1", text: "Exchange balances"
  end

  test "should create exchange balance" do
    visit exchange_balances_url
    click_on "New exchange balance"

    click_on "Create Exchange balance"

    assert_text "Exchange balance was successfully created"
    click_on "Back"
  end

  test "should update Exchange balance" do
    visit exchange_balance_url(@exchange_balance)
    click_on "Edit this exchange balance", match: :first

    click_on "Update Exchange balance"

    assert_text "Exchange balance was successfully updated"
    click_on "Back"
  end

  test "should destroy Exchange balance" do
    visit exchange_balance_url(@exchange_balance)
    click_on "Destroy this exchange balance", match: :first

    assert_text "Exchange balance was successfully destroyed"
  end
end
