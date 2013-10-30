json.array!(@confession_location_changes) do |confession_location_change|
  json.extract! confession_location_change, :name, :nickname, :street_address, :city, :state_id, :postal_code, :change_comments, :user_account_id, :confession_location_id
  json.url confession_location_change_url(confession_location_change, format: :json)
end
