class PartnerClient
  attr_reader :client

  def initialize(client)
    @client = client
  end

  def partner_client?
    return true if json_response.status == 200
  end

  def partnership
    json_response_body
  end

  private

  def json_response
    @json_response ||= VerifyPartnershipService.new(client).call
  end

  def json_response_body
    JSON.parse(json_response.body, symbolize_names: true)
  end
end
