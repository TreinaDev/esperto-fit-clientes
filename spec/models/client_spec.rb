require 'rails_helper'

RSpec.describe Client, type: :model do
  context 'respond_to' do
    it { is_expected.to respond_to(:email) }
    it { is_expected.to respond_to(:cpf) }
    it { is_expected.to respond_to(:partner?) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:cpf) }
    it { is_expected.to validate_presence_of(:email) }
    it 'Uniqueness CPF' do
      faraday_response = double('cpf_check', status: 404)
      allow(Faraday).to receive(:get).and_return(faraday_response)
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

  context '#cpf_banned?' do
    it 'status 200 from API' do
      allow_any_instance_of(Client).to receive(:cpf_banned?).and_call_original
      client = build(:client, status: nil)
      faraday_response = double('cpf_ban', status: 200)
      allow(Faraday).to receive(:get)
        .with("#{Rails.configuration.apis['subsidiaries']}banned_customer/#{CPF.new(client.cpf).stripped}")
        .and_return(faraday_response)

      response = client.cpf_banned?

      expect(response).to eq true
      expect(client.valid?).to eq true
    end

    it 'status 404 from API' do
      client = build(:client, status: nil)
      faraday_response = double('cpf_ban', status: 404)

      allow(Faraday).to receive(:get)
        .with("#{Rails.configuration.apis['subsidiaries']}banned_customer/#{CPF.new(client.cpf).stripped}")
        .and_return(faraday_response)

      response = client.cpf_banned?

      expect(response).to eq false
      expect(client.valid?).to eq true
    end

    it 'status 422 from API' do
      allow_any_instance_of(Client).to receive(:cpf_banned?).and_call_original
      client = build(:client, status: nil, cpf: '123456')
      faraday_response = double('cpf_ban', status: 422)

      allow(Faraday).to receive(:get)
        .with("#{Rails.configuration.apis['subsidiaries']}banned_customer/#{client.cpf}")
        .and_return(faraday_response)

      response = client.cpf_banned?

      expect(response).to eq nil
      expect(client.valid?).to eq false
    end

    it 'error on API' do
      allow_any_instance_of(Client).to receive(:cpf_banned?).and_call_original
      client = build(:client, status: nil)
      faraday_response = double('cpf_ban', status: 500)
      allow(Faraday).to receive(:get)
        .with("#{Rails.configuration.apis['subsidiaries']}banned_customer/#{CPF.new(client.cpf).stripped}")
        .and_return(faraday_response)

      response = client.cpf_banned?

      expect(response).to eq nil
      expect(client.valid?).to eq false
    end
  end
end
