FactoryBot.define do
  factory :personal do
    sequence(:email) { |i| "personal#{i}@email.com" }
    password {'password'}
    cpf {'08858754948'}
    cref {'001582-G/ES'}
    name {'Personal Test'}
  end
end
