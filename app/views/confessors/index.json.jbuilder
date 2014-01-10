json.array!(@confessors) do |confessor|
  json.extract! confessor, :id, :confessor_office_id, :diocese, :salutation, :confession_status_id, :confession_location_id, :confession_start_time, :confession_end_time, :confession_comments, :biography
  json.url confessor_url(confessor, format: :json)
end
