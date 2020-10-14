require 'rails_helper'

RSpec.describe Client, type: :model do
  context 'respond_to' do
    it { is_expected.to respond_to(:email) }
    it { is_expected.to respond_to(:cpf) }
    it { is_expected.to respond_to(:partner?) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:cpf) }
    # it { is_expected.to validate_uniqueness_of(:cpf) }
    it { is_expected.to validate_presence_of(:email) }
    it 'Uniqueness CPF' do
      create(:client, cpf: '08858754948')
      client = build(:client, cpf: '0885875-4948')
      client.valid?

      expect(client).to_not be_valid
      expect(client.errors[:cpf]).to include('já está em uso')
    end
  end

  context 'associations' do
    it { is_expected.to have_many(:order_appointments).dependent(:destroy) }
  end

  context 'verify partnership' do
    it '#partner? => true' do
      client = create(:client)
      allow(client).to receive(:partner?).and_return(true)

      expect(client.partner?).to be_truthy
    end

    it '#is_partner? => true' do
      client = create(:client, email: 'client@partner_company.com')

      expect(client.partner?).to be_truthy
    end

    it '#is_partner? => false' do
      client = create(:client)
      allow(client).to receive(:partner?).and_return(false)

      expect(client.partner?).to be_falsey
    end
  end
end
