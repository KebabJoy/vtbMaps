json.(
  bank_office,
    :id,
    :sale_point_name,
    :open_hours,
    :open_hours_individual,
    :status,
    :rko,
    :office_type,
    :sale_point_format,
    :load_value,
    :suo_availability,
    :has_ramp,
    :kep,
    :my_branch
)
json.partial! "departments_context/addresses/shared/address", point: bank_office.address
