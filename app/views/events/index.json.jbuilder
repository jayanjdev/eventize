json.array!(@events) do |event|
  json.extract! event, :id, :user_id, :description
  json.url event_url(event, format: :json)
end
