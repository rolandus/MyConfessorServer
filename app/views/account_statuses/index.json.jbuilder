json.array!(@account_statuses) do |account_status|
  json.extract! account_status, :name
  json.url account_status_url(account_status, format: :json)
end
