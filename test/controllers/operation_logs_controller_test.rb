require "test_helper"

class OperationLogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @operation_log = operation_logs(:one)
  end

  test "should get index" do
    get operation_logs_url
    assert_response :success
  end

  test "should get new" do
    get new_operation_log_url
    assert_response :success
  end

  test "should create operation_log" do
    assert_difference("OperationLog.count") do
      post operation_logs_url, params: { operation_log: { detail: @operation_log.detail, ip: @operation_log.ip, operation_type: @operation_log.operation_type, user_agent: @operation_log.user_agent, user_id: @operation_log.user_id } }
    end

    assert_redirected_to operation_log_url(OperationLog.last)
  end

  test "should show operation_log" do
    get operation_log_url(@operation_log)
    assert_response :success
  end

  test "should get edit" do
    get edit_operation_log_url(@operation_log)
    assert_response :success
  end

  test "should update operation_log" do
    patch operation_log_url(@operation_log), params: { operation_log: { detail: @operation_log.detail, ip: @operation_log.ip, operation_type: @operation_log.operation_type, user_agent: @operation_log.user_agent, user_id: @operation_log.user_id } }
    assert_redirected_to operation_log_url(@operation_log)
  end

  test "should destroy operation_log" do
    assert_difference("OperationLog.count", -1) do
      delete operation_log_url(@operation_log)
    end

    assert_redirected_to operation_logs_url
  end
end
