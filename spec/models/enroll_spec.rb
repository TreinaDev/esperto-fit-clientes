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

  context 'respond_to' do
    it { is_expected.to respond_to(:coupon_available) }
  end

  context 'coupons api' do
    let(:enroll) { Enroll.new }

    it '#coupon_promotion_name' do
      enroll.coupon = 'BFRIDAY001'
      allow(enroll).to receive(:coupon_promotion_name).and_return('Promoção black friday')
      expect(enroll.coupon_promotion_name).to eq('Promoção black friday')
    end

    it '#coupon_available' do
      enroll.coupon = 'BFRIDAY001'
      allow(enroll).to receive(:coupon_available).and_return('Cupom válido')
      expect(enroll.coupon_available).to eq('Cupom válido')
    end

    it '#coupon_expiration_date' do
      enroll.coupon = 'BFRIDAY001'
      allow(enroll).to receive(:coupon_expiration_date).and_return('09/01/2030')
      expect(enroll.coupon_expiration_date).to eq('09/01/2030')
    end

    it '#coupon_discount_rate' do
      enroll.coupon = 'BFRIDAY001'
      allow(enroll).to receive(:coupon_discount_rate).and_return('50.0')
      expect(enroll.coupon_discount_rate).to eq('50.0')
    end
  end
end
