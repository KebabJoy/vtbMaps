require_relative Rails.root.join('lib', 'gis_operations.rb')

bool_mapping = {
  "N" => false,
  "Y" => true,
  nil=>false
}.freeze
rko_bool_mapping = {
  "есть РКО" => true,
  "нет РКО" => false,
  nil=>false,
}.freeze


offices = JSON.parse(File.read('Data/offices.txt')).each do |hash|
  hash = hash.transform_keys { _1.underscore }.deep_symbolize_keys

  office_attributes = hash.slice(
    :sale_point_name,
    :open_hours,
    :open_hours_individual,
    :status,
    :office_type,
    :sale_point_format,
    :kep,
    :my_branch,
    :metro_station,
    :distance
  )
  office_attributes[:rko] = rko_bool_mapping[hash[:rko]]
  office_attributes[:has_ramp] = bool_mapping[hash[:has_ramp]]
  office_attributes[:suo_availability] = bool_mapping[hash[:suo_availability]]

  coords = GisOperations.hash_to_point(lat: hash[:latitude], lon: hash[:longitude])
  office_attributes[:address_attributes] = {raw_value: hash[:address], coords: coords}

  DepartmentsContext::BankOffice.create!(office_attributes)
end


atms = JSON.parse(File.read('Data/atms.txt'))['atms'].each do |hash|
  hash = hash.transform_keys { _1.underscore }.deep_symbolize_keys
  atm_attributes = hash.slice(:allday, :services)
  coords = GisOperations.hash_to_point(lat: hash[:latitude], lon: hash[:longitude])
  atm_attributes[:address_attributes] = {raw_value: hash[:address], coords: coords}

  DepartmentsContext::Atm.create!(atm_attributes)
end

create_table "atms", force: :cascade do |t|
  t.boolean "allday", default: false, comment: "Круглосуточно"
  t.jsonb "services", default: {}, null: false, comment: "Доступность отделения"
  t.datetime "created_at", null: false
  t.datetime "updated_at", null: false
end
