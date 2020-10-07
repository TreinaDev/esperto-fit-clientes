require 'rails_helper'

RSpec.describe Appointment, type: :model do
  context 'respond_to' do
    it { is_expected.to respond_to(:appointment_time) }
    it { is_expected.to respond_to(:appointment_date) }
    it { is_expected.to respond_to(:price_per_hour) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:personal) }
    it { is_expected.to validate_presence_of(:appointment_date) }
    it { is_expected.to validate_presence_of(:price_per_hour) }
  end

  context 'associations' do
    it {is_expected.to belong_to(:personal)}
  end
end
