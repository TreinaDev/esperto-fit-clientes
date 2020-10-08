class VerifyPartnershipService
  attr_reader :client

  def initialize(client)
    @client = client
  end

  def call
    verify_partnership
  end

  private

  def api_partnership_data
    { partners: %w[partner_company.com other_patner.com] }
  end

  def verify_partnership
    hash = api_partnership_data

    hash[:partners].include?(client.domain)
  end
end
