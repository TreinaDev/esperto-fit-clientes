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
    it 'status cannot be blank' do
      client = Client.create

      expect(client.errors[:status]).to include('ocorreu um erro, tente novamente mais tarde')
    end
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

  context '#cpf_get_status' do
    it 'response is true from API' do
      client = build(:client, status: nil)

      faraday_response = double('cpf_ban', status: 200, body: 'true')

      allow(Faraday).to receive(:get).with("http://subsidiaries/api/v1/banned_user/#{client.cpf}")
                                     .and_return(faraday_response)

      client.cpf_get_status

      expect(client.status).to eq 'banned'
    end

    it 'response is false from API' do
      client = build(:client, status: nil)
      faraday_response = double('cpf_ban', status: 200, body: 'false')

      allow(Faraday).to receive(:get).with("http://subsidiaries/api/v1/banned_user/#{client.cpf}")
                                     .and_return(faraday_response)

      client.cpf_get_status

      expect(client.status).to eq 'active'
    end

    it 'error on API' do
      client = build(:client, status: nil)

      faraday_response = double('cpf_ban', status: 500)

      allow(Faraday).to receive(:get).with("http://subsidiaries/api/v1/banned_user/#{client.cpf}")
                                     .and_return(faraday_response)

      client.cpf_get_status

      expect(client.status).to eq nil
      expect(client.valid?).to eq false
    end
  end
end
