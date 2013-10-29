json.array!(@confessor_statuses) do |confessor_status|
  json.extract! confessor_status, :name
  json.url confessor_status_url(confessor_status, format: :json)
end
