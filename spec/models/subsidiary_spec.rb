require 'rails_helper'

RSpec.describe Subsidiary, type: :model do
  context 'get all plans' do
    it 'successfully' do
      json_content = File.read(Rails.root.join('spec/support/apis/get_plans.json'))
      faraday_response = double('plans', status: 200, body: json_content)
      subsidiary = Subsidiary.new(id: 1, name: 'Vila Maria', address: 'Avenida Osvaldo Reis, 801',
                                  cnpj: '11189348000195', token: 'CK4XEB')
      allow(Faraday).to receive(:get).with("#{subsidiary.id}/api/plans")
                                     .and_return(faraday_response)
      result = subsidiary.plans

      expect(result.length).to eq 2
      expect(result.first.name).to eq 'Esperto'
      expect(result.first.monthly_payment).to eq 10
      expect(result.first.permanency).to eq 12
      expect(result.last.name).to eq 'Espertão'
    end

    it 'result is empty' do
      faraday_response = double('plans', status: 200, body: '[]')
      subsidiary = Subsidiary.new(id: 1, name: 'Vila Maria', address: 'Avenida Osvaldo Reis, 801',
                                  cnpj: '11189348000195', token: 'CK4XEB')
      allow(Faraday).to receive(:get).with("#{subsidiary.id}/api/plans")
                                     .and_return(faraday_response)
      result = subsidiary.plans

      expect(result.length).to eq 0
    end

    it 'error on API' do
      faraday_response = double('plans', status: 500)
      subsidiary = Subsidiary.new(id: 1, name: 'Vila Maria', address: 'Avenida Osvaldo Reis, 801',
                                  cnpj: '11189348000195', token: 'CK4XEB')
      allow(Faraday).to receive(:get).with("#{subsidiary.id}/api/plans")
                                     .and_return(faraday_response)
      result = subsidiary.plans

      expect(result.length).to eq 0
    end
  end

  describe 'get all subsidiaries' do
    it 'fetch all subsidiaries from API' do
      json_content = File.read(Rails.root.join('spec/support/apis/get_subsidiaries.json'))
      faraday_response = double('subs', status: 200, body: json_content)
      allow(Faraday).to receive(:get).with("#{Rails.configuration.apis['subsidiaries']}/subsidiaries")
                                     .and_return(faraday_response)

      result = Subsidiary.all

      expect(result.length).to eq 2
      expect(result.first.name).to eq 'Lorem1'
      expect(result.last.name).to eq 'Lorem2'
    end

    it 'fetch no subsidiaries from API' do
      faraday_response = double('subs', status: 200, body: '[]')

      allow(Faraday).to receive(:get).with("#{Rails.configuration.apis['subsidiaries']}/subsidiaries")
                                     .and_return(faraday_response)

      result = Subsidiary.all

      expect(result.length).to eq 0
    end

    it 'error on API' do
      faraday_response = double('subs', status: 500)

      allow(Faraday).to receive(:get).with("#{Rails.configuration.apis['subsidiaries']}/subsidiaries")
                                     .and_return(faraday_response)

      result = Subsidiary.all

      expect(result.length).to eq 0
    end
  end
end
