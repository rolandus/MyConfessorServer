json.array!(@confessional_locations) do |confessional_location|
  json.extract! confessional_location, :name, :nickname, :street_address, :city, :state
  json.url confessional_location_url(confessional_location, format: :json)
end
