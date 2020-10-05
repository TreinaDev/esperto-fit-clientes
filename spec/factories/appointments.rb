FactoryBot.define do
  factory :appointment do
    appointment_date {'06/10/2020'}
    appointment_time {'12:00'}
    subsidiary { Subsidiary.new(name: 'Subsidiary Name') }
  end
end
