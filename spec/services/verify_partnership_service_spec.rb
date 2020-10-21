require 'rails_helper'

describe VerifyPartnershipService do
  context '#call' do
    let(:client) do
      faraday_response = double('cpf_check', status: 404)
      allow(Faraday).to receive(:get).with("#{Rails.configuration.apis['subsidiaries']}banned_customer/47814531802")
                                     .and_return(faraday_response)
      create(:client, email: 'client@partner_company.com', cpf: '47814531802')
    end
    subject { VerifyPartnershipService.new(client) }

    it 'returns Faraday::Response' do
      allow(subject).to receive(:call).and_return(Faraday::Response)
      expect(subject.call).to eq(Faraday::Response)
    end
  end
end
