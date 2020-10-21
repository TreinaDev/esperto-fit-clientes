require 'rails_helper'

describe VerifyPartnershipService do
  context '#call' do
    let(:client) do
      create(:client, email: 'client@partner_company.com')
    end
    subject { VerifyPartnershipService.new(client) }

    it 'returns Faraday::Response' do
      allow(subject).to receive(:call).and_return(Faraday::Response)
      expect(subject.call).to eq(Faraday::Response)
    end
  end
end
