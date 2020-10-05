class VerifyPartnershipService
  attr_reader :client

  def initialize(client)
    @client = client
  end

  def call
    verify_partnership
  end

  def api_partnership_data
    { partners: %i[partner_company.com other_patner.com] }
  end

  def verify_partnership
    hash = api_partnership_data
    partner_email = client.email.split('@')[1]

    hash[:partners].include?(partner_email.to_sym)
  end
end
