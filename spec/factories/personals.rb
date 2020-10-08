FactoryBot.define do
  factory :personal do
    sequence(:name) { |i| "Nome#{i}" }
    sequence(:email) { |i| "test#{i}@email.com" }
    password { 'password' }
    cpf { CPF.generate(formatted: true) }
    sequence(:cref) { |i| "#{1_000_000 - i}-G/SP" }
  end
end
