json.array!(@confession_statuses) do |confession_status|
  json.extract! confession_status, :id, :name
  json.url confession_status_url(confession_status, format: :json)
end
