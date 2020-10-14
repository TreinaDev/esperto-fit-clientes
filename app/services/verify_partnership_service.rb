class VerifyPartnershipService
  attr_reader :client

  def initialize(client)
    @client = client
  end

  def call
    api_partnership_data
  end

  private

  def api_partnership_data
    uri = 'http://localhost:4000/api/v1/partner_companies/search/'
    Faraday.get(uri, { q: client.cpf })
  end
end
