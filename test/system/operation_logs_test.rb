require "application_system_test_case"

class OperationLogsTest < ApplicationSystemTestCase
  setup do
    @operation_log = operation_logs(:one)
  end

  test "visiting the index" do
    visit operation_logs_url
    assert_selector "h1", text: "Operation logs"
  end

  test "should create operation log" do
    visit operation_logs_url
    click_on "New operation log"

    fill_in "Detail", with: @operation_log.detail
    fill_in "Ip", with: @operation_log.ip
    fill_in "Operation type", with: @operation_log.operation_type
    fill_in "User agent", with: @operation_log.user_agent
    fill_in "User", with: @operation_log.user_id
    click_on "Create Operation log"

    assert_text "Operation log was successfully created"
    click_on "Back"
  end

  test "should update Operation log" do
    visit operation_log_url(@operation_log)
    click_on "Edit this operation log", match: :first

    fill_in "Detail", with: @operation_log.detail
    fill_in "Ip", with: @operation_log.ip
    fill_in "Operation type", with: @operation_log.operation_type
    fill_in "User agent", with: @operation_log.user_agent
    fill_in "User", with: @operation_log.user_id
    click_on "Update Operation log"

    assert_text "Operation log was successfully updated"
    click_on "Back"
  end

  test "should destroy Operation log" do
    visit operation_log_url(@operation_log)
    click_on "Destroy this operation log", match: :first

    assert_text "Operation log was successfully destroyed"
  end
end
