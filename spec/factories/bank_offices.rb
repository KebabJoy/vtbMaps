FactoryBot.define do
  factory :bank_office, class: DepartmentsContext::BankOffice do
    sale_point_name { Faker.name }
    status { "открыто" }
    rko { true }
    office_type { "value" }
    sale_point_format { "value" }
    metro_station { "value" }
    distance { 400 }
    load_value { 10 }
  end
end
