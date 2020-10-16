require 'rails_helper'

describe PartnerClient, :vcr do
  let(:client) { create(:client, cpf: '816.125.298-01') }
  let(:partner) { PartnerClient.new(client) }

  it '#partnership' do
    expect(partner.partnership).to be_a(Hash)
  end

  it '#partner company name' do
    expect(partner.partnership[:name]).to eq('Empresa1')
  end

  it '#partner discount' do
    expect(partner.partnership[:discount]).to eq('30.0')
  end

  it '#partner company name' do
    expect(partner.partnership[:format_discount_duration]).to eq('12')
  end
end
