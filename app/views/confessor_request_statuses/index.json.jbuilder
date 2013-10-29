json.array!(@confessor_request_statuses) do |confessor_request_status|
  json.extract! confessor_request_status, :name
  json.url confessor_request_status_url(confessor_request_status, format: :json)
end
