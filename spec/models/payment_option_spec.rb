require 'rails_helper'

RSpec.describe PaymentOption, type: :model do
  context 'validation' do
    it 'attribute cannot be blank' do
      payment_option = PaymentOption.new

      payment_option.valid?

      expect(payment_option.errors[:name]).to include('não pode ficar em branco')
    end

    it 'name must be unique' do
      PaymentOption.create(name: 'Nome')
      payment_option = PaymentOption.new(name: 'Nome')

      payment_option.valid?

      expect(payment_option.errors[:name]).to include('já está em uso')
    end
  end
end
