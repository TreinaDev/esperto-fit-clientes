require 'rails_helper'

describe VerifyPartnershipService do
  context '#call' do
    let(:client) do
      faraday_response = double('cpf_check', status: 200, body: 'false')
      allow(Faraday).to receive(:get).with('http://subsidiaries/api/v1/banned_user/47814531802')
                                     .and_return(faraday_response)
      create(:client, email: 'client@partner_company.com', cpf: '47814531802')
    end
    subject { VerifyPartnershipService.new(client) }

    it 'returns true' do
      expect(subject.call).to be_truthy
    end

    it 'returns false' do
      allow(subject).to receive(:api_partnership_data).and_return({ partners: [] })
      expect(subject.call).to be_falsey
    end
  end
end
