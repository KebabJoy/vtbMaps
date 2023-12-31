json.array!(@bank_offices) do |bank_office|
  json.(
    bank_office,
      :sale_point_name,
      :open_hours,
      :open_hours_individual,
      :status,
      :rko,
      :office_type,
      :sale_point_format
  )
  json.partial! "departments_context/addresses/shared/address", point: bank_office.address
end

