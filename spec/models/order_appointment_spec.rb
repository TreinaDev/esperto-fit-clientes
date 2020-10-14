require 'rails_helper'

RSpec.describe OrderAppointment, type: :model do
  context 'associations' do
    it { is_expected.to belong_to(:client) }
    it { is_expected.to belong_to(:appointment) }
    it { is_expected.to belong_to(:client) }
  end
end
