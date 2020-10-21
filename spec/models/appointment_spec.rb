require 'rails_helper'

RSpec.describe Appointment, type: :model do
  context 'respond_to' do
    it { is_expected.to respond_to(:appointment_time) }
    it { is_expected.to respond_to(:appointment_date) }
    it { is_expected.to respond_to(:price_per_hour) }
    it { is_expected.to respond_to(:status) }
    it { is_expected.to define_enum_for(:status).with_values(available: 0, ordered: 10, canceled: 20) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:personal) }
    it { is_expected.to validate_presence_of(:appointment_date) }
    it { is_expected.to validate_presence_of(:price_per_hour) }
    it 'Appointment date cant be before today' do
      appointment = build(:appointment, appointment_date: -1.day.from_now)
      appointment.valid?

      expect(appointment).to_not be_valid
      expect(appointment.errors[:appointment_date]).to include('não é válido')
    end

    it 'Appointment date can be today' do
      appointment = build(:appointment, appointment_date: Time.zone.today)
      appointment.valid?

      expect(appointment).to be_valid
    end
  end

  context 'associations' do
    it { is_expected.to belong_to(:personal) }
    it { is_expected.to have_one(:order_appointment).dependent(:destroy) }
  end
end
