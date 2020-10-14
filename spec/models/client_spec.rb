require 'rails_helper'

RSpec.describe Client, type: :model do
  context 'respond_to' do
    it { is_expected.to respond_to(:email) }
    it { is_expected.to respond_to(:cpf) }
    it { is_expected.to respond_to(:partner?) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:cpf) }
    it { is_expected.to validate_uniqueness_of(:cpf) }
    it { is_expected.to validate_presence_of(:email) }
  end

  context 'associations' do
    it { is_expected.to have_many(:order_appointments).dependent(:destroy) }
  end

  context 'verify partnership' do
    let(:client) { create(:client, cpf: '816.125.298-01') }

    it '#partner? => true' do
      allow(client).to receive(:partner?).and_return(true)

      expect(client.partner?).to be_truthy
    end

    it '#company_name' do
      allow(client).to receive(:company_name).and_return('Empresa1')

      expect(client.company_name).to eq('Empresa1')
    end

    it '#partner_discount' do
      allow(client).to receive(:partner_discount).and_return('30.0')

      expect(client.partner_discount).to eq('30.0')
    end

    it '#discount_duration' do
      allow(client).to receive(:discount_duration).and_return('12')

      expect(client.discount_duration).to eq('12')
    end

    it '#is_partner? => false' do
      allow(client).to receive(:partner?).and_return(false)

      expect(client.partner?).to be_falsey
    end
  end
end
