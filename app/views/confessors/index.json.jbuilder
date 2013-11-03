json.array!(@confessors) do |confessor|
  json.extract! confessor, :confessor_office_id, :salutation, :confession_status_id, :confession_location_id, :confession_start_time, :confession_end_time, :confession_comments, :biography
  json.url confessor_url(confessor, format: :json)
end
