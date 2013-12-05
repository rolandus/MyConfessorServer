json.array!(@confessor_changes) do |confessor_change|
  json.extract! confessor_change, :id, :confessor_office_id, :salutation, :user_account_id, :biography, :change_comments, :changed_by_user_account_id
  json.url confessor_change_url(confessor_change, format: :json)
end
