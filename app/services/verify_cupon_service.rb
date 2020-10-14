class VerifyPartnershipService
  attr_reader :token

  def initialize(token)
    @token = token
  end

  def call
    uri = "http://localhost:5000/api/v1/coupons/#{token}"
    Faraday.get(uri)
  end
end
