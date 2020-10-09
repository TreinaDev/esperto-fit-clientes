require 'rails_helper'

describe 'Ban user' do
  context 'GET /api/user/:user_cpf/ban' do
    context 'with valid parameters' do
      it 'return 200 status if user have client account' do
        client = create(:client)

        get "/api/user/#{CPF.new(client.cpf).stripped}/ban"

        expect(response).to be_ok
        expect(response.body).to include('Cliente banido com sucesso')
      end

      it 'return 200 status if user have personal account' do
        personal = create(:personal)

        get "/api/user/#{CPF.new(personal.cpf).stripped}/ban"

        expect(response).to be_ok
        expect(response.body).to include('Personal banido com sucesso')
      end

      it 'return 200 if client already banned' do
        client = create(:client, status: 'banned')

        get "/api/user/#{CPF.new(client.cpf).stripped}/ban"

        expect(response).to be_ok
        expect(response.body).to include('Cliente já banido anteriormente')
      end

      it 'return 200 if personal already banned' do
        personal = create(:personal, status: 'banned')

        get "/api/user/#{CPF.new(personal.cpf).stripped}/ban"

        expect(response).to be_ok
        expect(response.body).to include('Personal já banido anteriormente')
      end

      it 'return 404 if user dont have account' do
        get '/api/user/08858754948/ban'

        expect(response).to be_not_found
        expect(response.body).to include('O usuário não possui cadastro ativo')
      end
    end

    it 'with invalid cpf' do
      get '/api/user/123/ban'

      expect(response).to be_precondition_failed
      expect(response.body).to include('CPF inválido')
    end
  end
end
