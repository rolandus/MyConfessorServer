json.array!(@user_locations) do |user_location|
  json.extract! user_location, :user_id, :confessional_location_id, :location_details
  json.url user_location_url(user_location, format: :json)
end
