FactoryBot.define do
  factory :appointment do
    appointment_date { Time.zone.today }
    appointment_time { '12:00' }
    price_per_hour { 100 }
    personal
    status { 'available' }
  end
end
