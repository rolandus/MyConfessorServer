json.array!(@confession_locations) do |confession_location|
  json.extract! confession_location, :name, :nickname, :street_address, :city, :state_id, :postal_code
  json.url confession_location_url(confession_location, format: :json)
end
