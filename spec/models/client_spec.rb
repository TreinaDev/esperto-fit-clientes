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
    let(:client) { create(:client, cpf: '816.125.298-01') }

    it '#partner? => true' do
      VCR.use_cassette('client/method_partner?') do
        expect(client.partner?).to be_truthy
      end
    end


    it '#is_partner? => false' do
      allow(client).to receive(:partner?).and_return(false)

      expect(client.partner?).to be_falsey
    end
  end
end
