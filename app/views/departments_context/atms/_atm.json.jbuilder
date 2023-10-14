json.(atm, :id, :allday, :services)
json.partial! "departments_context/addresses/shared/address", point: atm.address
