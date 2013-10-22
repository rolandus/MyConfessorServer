json.array!(@users) do |user|
  json.extract! user, :first_name, :last_name, :home_phone, :mobile_phone, :email, :street_address, :city, :state, :diocese, :parish, :password, :office, :salutation, :photo, :about_me, :account_status, :confessional_status, :confessional_location_id, :confessional_date, :confessional_start_time, :confessional_end_time, :confessional_details
  json.url user_url(user, format: :json)
end
