FactoryBot.define do
  factory :enroll do
    client
    plan_id { 1 }
    payment_option { PaymentOption.last }
    subsidiary_id { 1 }
  end
end
