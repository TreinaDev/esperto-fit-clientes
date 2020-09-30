FactoryBot.define do
  factory :client do
    name { 'Joãozinho Santos' }
    email { 'joaozinho@email.com' }
    password { '123456' }
    cpf { '753.983.030-15' }
  end
end
