require 'rails_helper'

describe 'Clients API' do
  context 'index' do
    it 'return clients' do 
      clients = create_list(:client, 2)

      get '/api/v1/clients'
  
      expect(response).to have_http_status(200)
      expect(response.body).to include(clients[0].cpf)
      expect(response.body).to include(clients[0].email)
      expect(response.body).to include(clients[1].cpf)
      expect(response.body).to include(clients[1].email)
    end

    it 'returns []' do
      get '/api/v1/clients'
      
      response_json = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(response_json).to be_empty
    end
  end

  context 'GET /api/v1/client/:id' do
    context 'Record exists' do
      let(:client) { create(:client) }

      it 'returns client' do
        get "/api/v1/clients/#{client.id}"

        response_json = JSON.parse(response.body)

        expect(response).to have_http_status(200)
        expect(json_response).to include(client.cpf)
        expect(json_response).to include(client.email)
      end
    end

  end
end
