json.extract! log, :id, :aircraft, :reg, :start, :stop, :captain, :capacity, :from, :to, :created_at, :updated_at
json.url log_url(log, format: :json)
