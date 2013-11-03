json.array!(@user_account_changes) do |user_account_change|
  json.extract! user_account_change, :first_name, :last_name, :username, :password, :account_status_id, :email, :home_phone, :work_phone, :mobile_phone, :confessor_id, :change_comments, :user_account_id, :changed_by_user_account_id
  json.url user_account_change_url(user_account_change, format: :json)
end
