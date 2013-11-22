json.array!(@confessor_request_changes) do |confessor_request_change|
  json.extract! confessor_request_change, :first_name, :last_name, :diocese_id, :state_id, :confessor_request_status_id, :change_comments, :changed_by_user_account_id, :confessor_request_id
  json.url confessor_request_change_url(confessor_request_change, format: :json)
end
