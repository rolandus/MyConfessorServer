json.array!(@user_accounts) do |user_account|
  json.extract! user_account, :first_name, :last_name, :username, :password, :account_status_id, :email, :home_phone, :work_phone, :mobile_phone
  json.url user_account_url(user_account, format: :json)
end
