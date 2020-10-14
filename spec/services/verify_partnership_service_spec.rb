require 'rails_helper'

describe VerifyPartnershipService do
  context '#call' do
    let(:client) { create(:client, cpf: '816.125.298-01') }

    subject { VerifyPartnershipService.new(client) }

    it 'returns Faraday::Response' do
      expect(subject.call).to be_a(Faraday::Response)
    end
  end
end
