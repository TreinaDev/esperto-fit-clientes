require 'rails_helper'

describe VerifyCouponService do
  it '#call' do
    service = VerifyCouponService.new("BFRIDAY001")
    response_body = {
      "available": "Cupom válido",
      "discount_rate": "100.0",
      "monthly_duration": "6",
      "expire_date_formatted": "09/09/2024",
      "promotion": "Promoção de natal"
     }

    allow(service).to receive(:call).and_return(response_body)

    expect(service.call).to eq(response_body)
  end
end
