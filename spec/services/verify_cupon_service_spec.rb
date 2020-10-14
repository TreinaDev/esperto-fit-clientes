require 'rails_helper'

describe VerifyCuponService do
  it 'response' do
    service = VerifyCuponService.new
    allow(service).to receive(:call).and_return(response)
    response ={
  "available": "Cupom válido",
  "discount_rate": "100.0",
  "monthly_duration": "6",
  "expire_date_formatted": "09/09/2024",
  "promotion": "Promoção de natal"
    }.to_json 
    expect(service).to eq(response)
  end
end
