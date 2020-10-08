require 'rails_helper'

RSpec.describe Enroll, type: :model do
  context 'validation' do
    it 'attibutes cannot be blank' do
      enroll = Enroll.new

      enroll.valid?

      expect(enroll.errors[:plan_id]).to include('não pode ficar em branco')
      expect(enroll.errors[:subsidiary_id]).to include('não pode ficar em branco')
      expect(enroll.errors[:payment_option]).to include('é obrigatório(a)')
      expect(enroll.errors[:client]).to include('é obrigatório(a)')
    end
  end
end
