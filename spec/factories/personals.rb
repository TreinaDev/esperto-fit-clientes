FactoryBot.define do
  factory :personal do
    sequence(:email) { |i| "personal#{i}@email.com" }
    password { '123456' }
    sequence(:name) { |i| "Fulano #{i}" }
    sequence(:cref) { |i| "00000#{i}-G/SP" }
    cpf { CPF.generate(true) }
  end
end
