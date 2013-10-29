json.array!(@dioceses) do |diocese|
  json.extract! diocese, :name, :full_name, :state_id
  json.url diocese_url(diocese, format: :json)
end
