FactoryBot.define do
  factory :profile do
    name { 'Aluno' }
    address { 'Av. Paulista' }
    enroll
  end
end
