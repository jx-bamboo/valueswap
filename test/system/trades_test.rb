require "application_system_test_case"

class TradesTest < ApplicationSystemTestCase
  setup do
    @trade = trades(:one)
  end

  test "visiting the index" do
    visit trades_url
    assert_selector "h1", text: "Trades"
  end

  test "should create trade" do
    visit trades_url
    click_on "New trade"

    fill_in "Action", with: @trade.action
    fill_in "Admin", with: @trade.admin_id
    fill_in "Coin", with: @trade.coin_id
    fill_in "Executed at", with: @trade.executed_at
    fill_in "Fee", with: @trade.fee
    fill_in "Order", with: @trade.order_id
    fill_in "Price", with: @trade.price
    fill_in "Profit loss", with: @trade.profit_loss
    fill_in "Quantity", with: @trade.quantity
    fill_in "Status", with: @trade.status
    fill_in "Total amount", with: @trade.total_amount
    fill_in "Trade type", with: @trade.trade_type
    fill_in "User exchange", with: @trade.user_exchange_id
    fill_in "User", with: @trade.user_id
    click_on "Create Trade"

    assert_text "Trade was successfully created"
    click_on "Back"
  end

  test "should update Trade" do
    visit trade_url(@trade)
    click_on "Edit this trade", match: :first

    fill_in "Action", with: @trade.action
    fill_in "Admin", with: @trade.admin_id
    fill_in "Coin", with: @trade.coin_id
    fill_in "Executed at", with: @trade.executed_at.to_s
    fill_in "Fee", with: @trade.fee
    fill_in "Order", with: @trade.order_id
    fill_in "Price", with: @trade.price
    fill_in "Profit loss", with: @trade.profit_loss
    fill_in "Quantity", with: @trade.quantity
    fill_in "Status", with: @trade.status
    fill_in "Total amount", with: @trade.total_amount
    fill_in "Trade type", with: @trade.trade_type
    fill_in "User exchange", with: @trade.user_exchange_id
    fill_in "User", with: @trade.user_id
    click_on "Update Trade"

    assert_text "Trade was successfully updated"
    click_on "Back"
  end

  test "should destroy Trade" do
    visit trade_url(@trade)
    click_on "Destroy this trade", match: :first

    assert_text "Trade was successfully destroyed"
  end
end
