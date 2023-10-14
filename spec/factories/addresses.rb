FactoryBot.define do
  factory :address, class: DepartmentsContext::Address do
    raw_value { "test" }

    coords { GisOperations.to_rgeo_point(Faker::Address.latitude, Faker::Address.longitude) }

    trait :within_50_km_from_moscow do
      coords { "POINT(37.317644 55.755819)" }
    end
  end
end
