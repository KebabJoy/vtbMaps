json.array!(@bank_offices) do |bank_office|
  json.sale_point_name bank_office.sale_point_name
  json.open_hours bank_office.open_hours
  json.open_hours_individual bank_office.open_hours_individual
  json.status bank_office.status
  json.rko bank_office.rko
  json.office_type bank_office.office_type
  json.sale_point_format bank_office.sale_point_format
end

