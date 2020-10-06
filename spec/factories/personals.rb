FactoryBot.define do
  factory :personal do
    sequence(:email) { |i| "personal#{i}@email.com" }
    password {'password'}
  end
end
