FactoryBot.define do
  factory :atm, class: DepartmentsContext::Atm do
    allday { true }
    services { {} }
  end
end
