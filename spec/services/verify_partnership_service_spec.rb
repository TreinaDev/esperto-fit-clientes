require 'rails_helper'

describe VerifyPartnershipService do
  context '#call' do
    let(:client) do
      create(:client, email: 'client@partner_company.com')
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
