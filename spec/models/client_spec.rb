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
    it { is_expected.to validate_presence_of(:email) }
  end

  context 'verify partnership' do
    it '#partner? => true' do
      faraday_response = double('cpf_check', status: 200, body: 'false')
      allow(Faraday).to receive(:get).with('http://subsidiaries/api/v1/banned_user/47814531802')
                                     .and_return(faraday_response)
      client = create(:client, cpf: '478.145.318-02')
      allow(client).to receive(:partner?).and_return(true)

      expect(client.partner?).to be_truthy
    end

    it '#is_partner? => true' do
      faraday_response = double('cpf_check', status: 200, body: 'false')
      allow(Faraday).to receive(:get).with('http://subsidiaries/api/v1/banned_user/47814531802')
                                     .and_return(faraday_response)
      client = create(:client, email: 'client@partner_company.com', cpf: '478.145.318-02')

      expect(client.partner?).to be_truthy
    end

    it '#is_partner? => false' do
      faraday_response = double('cpf_check', status: 200, body: 'false')
      allow(Faraday).to receive(:get).with('http://subsidiaries/api/v1/banned_user/47814531802')
                                     .and_return(faraday_response)
      client = create(:client, cpf: '478.145.318-02')
      allow(client).to receive(:partner?).and_return(false)

      expect(client.partner?).to be_falsey
    end
  end

  context '#cpf_get_status' do
    it 'response is true from API' do
      client = build(:client, status: nil)

      faraday_response = double('cpf_ban', status: 200, body: 'true')

      allow(Faraday).to receive(:get).with("http://subsidiaries/api/v1/banned_user/#{CPF.new(client.cpf).stripped}")
                                     .and_return(faraday_response)

      client.cpf_get_status

      expect(client.status).to eq 'banned'
    end

    it 'response is false from API' do
      client = build(:client, status: nil)
      faraday_response = double('cpf_ban', status: 200, body: 'false')

      allow(Faraday).to receive(:get).with("http://subsidiaries/api/v1/banned_user/#{CPF.new(client.cpf).stripped}")
                                     .and_return(faraday_response)

      client.cpf_get_status

      expect(client.status).to eq 'active'
    end

    it 'error on API' do
      client = build(:client, status: nil)

      faraday_response = double('cpf_ban', status: 500)

      allow(Faraday).to receive(:get).with("http://subsidiaries/api/v1/banned_user/#{CPF.new(client.cpf).stripped}")
                                     .and_return(faraday_response)

      client.cpf_get_status

      expect(client.status).to eq nil
      expect(client.valid?).to eq false
    end
  end
end
