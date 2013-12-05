json.array!(@confessor_offices) do |confessor_office|
  json.extract! confessor_office, :id, :name
  json.url confessor_office_url(confessor_office, format: :json)
end
