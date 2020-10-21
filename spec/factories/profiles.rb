FactoryBot.define do
  factory :profile do
    name { Faker::Name.unique.name }
    address { Faker::Address.full_address }
    enroll
  end
end
