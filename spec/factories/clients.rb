FactoryBot.define do
  factory :client do
    sequence(:email) { |i| "test#{i}@email.com" }
    password { 'password' }
    cpf { CPF.generate(formatted: true) }
    status { 'active' }
  end
end
