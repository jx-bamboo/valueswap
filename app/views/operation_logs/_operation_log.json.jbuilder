json.extract! operation_log, :id, :operation_type, :detail, :ip, :user_agent, :user_id, :created_at, :updated_at
json.url operation_log_url(operation_log, format: :json)
