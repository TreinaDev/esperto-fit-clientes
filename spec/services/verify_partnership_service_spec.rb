require 'rails_helper'

describe VerifyPartnershipService do
  context '#call' do
    it 'returns true' do
      client = create(:client, email: 'client@partner_company.com')

      expect(VerifyPartnershipService.new(client).call).to be_truthy
    end

    it 'returns false' do
      client = create(:client, email: 'client@not_partner.com')

      expect(VerifyPartnershipService.new(client).call).to be_falsey
    end
  end

  context '#api_partnership_data' do
    it 'hash with :partners key and [] values with partners' do
      client = create(:client, email: 'client@not_partner.com')
      service = VerifyPartnershipService.new(client)

      expect(service.api_partnership_data).to be_a(Hash)
      expect(service.api_partnership_data).to have_key(:partners)
    end
  end

  context '#verify_partnership' do
    it 'client included on partners hash' do
      client = create(:client, email: 'client@partner_company.com')
      service = VerifyPartnershipService.new(client)

      expect(service.verify_partnership).to be_truthy
    end

    it 'client not included on partners hash' do
      client = create(:client, email: 'client@not_partner.com')
      service = VerifyPartnershipService.new(client)

      expect(service.verify_partnership).to be_falsey
    end
  end
end
