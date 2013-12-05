json.array!(@account_roles) do |account_role|
  json.extract! account_role, :id, :name
  json.url account_role_url(account_role, format: :json)
end
