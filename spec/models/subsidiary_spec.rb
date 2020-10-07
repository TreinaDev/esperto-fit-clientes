require 'rails_helper'

describe Subsidiary, type: :model do
  describe '#all' do
    it 'fetch all subsidiaries from API' do
      json_content = File.read(Rails.root.join("spec/support/apis/get_subsidiaries.json"))
      faraday_response = double("subs", status: 200, body: json_content)

      allow(Faraday).to receive(:get).with("#{Rails.configuration.apis['subsidiaries']}/subsidiaries")
                                     .and_return(faraday_response)


      result = Subsidiary.all

      expect(result.length).to eq 2
      expect(result.first.name).to eq 'Lorem1'
      expect(result.last.name).to eq 'Lorem2'
    end

    it 'fetch no subsidiaries from API' do
      faraday_response = double("subs", status: 200, body: "[]")

      allow(Faraday).to receive(:get).with("#{Rails.configuration.apis['subsidiaries']}/subsidiaries")
                                     .and_return(faraday_response)

      result = Subsidiary.all

      expect(result.length).to eq 0
    end

    it 'error on API' do
      faraday_response = double("subs", status: 500)

      allow(Faraday).to receive(:get).with("#{Rails.configuration.apis['subsidiaries']}/subsidiaries")
                                     .and_return(faraday_response)

      result = Subsidiary.all

      expect(result.length).to eq 0
    end
  end
end