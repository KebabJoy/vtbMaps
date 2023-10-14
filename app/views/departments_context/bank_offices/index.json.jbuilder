json.array!(@bank_offices) do |bank_office|
  json.partial! "departments_context/bank_offices/bank_office", bank_office: bank_office
end

