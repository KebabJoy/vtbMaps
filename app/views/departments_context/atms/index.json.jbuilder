json.array!(@atms) do |atm|
  json.(atm, :allday, :services)
  json.partial! "departments_context/addresses/shared/address", point: atm.address
end

