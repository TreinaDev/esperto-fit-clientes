require 'rails_helper'

describe 'Clients API' do
  context 'index' do
    it 'return clients' do 
      clients = create_list(:client, 2)

      get 'api/v1/clients'
  
      expect(response).to have_http_status(200)
      expect(response.body).to include(clients[0].cpf)
      expect(response.body).to include(clients[0].email)
      expect(response.body).to include(clients[1].cpf)
      expect(response.body).to include(clients[1].email)
    end
  end
end