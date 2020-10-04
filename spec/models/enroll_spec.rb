require 'rails_helper'

RSpec.describe Enroll, type: :model do
  context 'validation' do
    it 'attibutes cannot be blank' do
      enroll = Enroll.new

      enroll.valid?

      expect(enroll.errors[:plan_id]).to include('não pode ficar em branco')
      expect(enroll.errors[:payment_option_id]).to include('não pode ficar em branco')
      expect(enroll.errors[:subsidiary_id]).to include('não pode ficar em branco')
      expect(enroll.errors[:client_id]).to include('não pode ficar em branco')
    end
  end
end
