FactoryBot.define do
  factory :client do
    email { 'client@email.com' }
    password { 'password' }
    cpf { '082.923.869-71' }
  end
end
