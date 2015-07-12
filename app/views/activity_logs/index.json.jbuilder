json.array!(@activity_logs) do |activity_log|
  json.extract! activity_log, :id, :netid, :browser, :ip_address, :controller, :action, :params, :note
  json.url activity_log_url(activity_log, format: :json)
end
