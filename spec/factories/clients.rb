FactoryBot.define do
  factory :client do
    name { 'Joãozinho Santos' }
    email { 'joaozinho@email.com' }
    password { '123456' }
    cpf { '753.983.030-15' }
    address { 'Rua A, 110' }
  end
end
