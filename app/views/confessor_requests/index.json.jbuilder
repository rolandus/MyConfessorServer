json.array!(@confessor_requests) do |confessor_request|
  json.extract! confessor_request, :first_name, :last_name, :diocese_id, :state_id, :confessor_request_status_id
  json.url confessor_request_url(confessor_request, format: :json)
end
