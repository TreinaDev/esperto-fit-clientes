module Client::PartnerClient
  def partner?
    return true if json_response.status == 200
  end

  def company_name
    json_response_body[:name]
  end

  def partner_discount
    json_response_body[:discount]
  end

  def discount_duration
    json_response_body[:format_discount_duration]
  end

  private

  def json_response
    VerifyPartnershipService.new(self).call
  end

  def json_response_body
    JSON.parse(json_response.body, symbolize_names: true)
  end
end
