json.array!(@atms) do |atm|
  json.partial! "departments_context/atms/atm", atm: atm
end

