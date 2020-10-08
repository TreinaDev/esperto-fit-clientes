require 'rails_helper'

describe 'Ban user' do
  context 'POST /api/user/:user_cpf/ban' do
    context 'with valid parameters' do
      it 'return 200 status if user have client account' do
        create(:client)

        post "/api/user/#{client.cpf}/ban"

        expect(response).to be_ok
        expect(response.body).to include('Usuário banido com sucesso')
      end

      it 'return 200 status if user have personal account' do
        create(:personal)

        post "/api/user/#{personal.cpf}/ban"

        expect(response).to be_ok
        expect(response.body).to include('Usuário banido com sucesso')
      end

      it 'return 409 if user already banned' do
        create(:client, status: 'banned')

        post "/api/user/#{client.cpf}/ban"

        expect(response).to be_conflict
        expect(response.body).to include('Usuário já banido anteriormente')
      end

      it 'return 404 if user dont have account' do
        post "/api/user/#{CPF.generate(formatted: true)}/ban"

        expect(response).to be_not_found
        expect(response.body).to include('O usuário não possui cadastro ativo')
      end
    end

    it 'with invalid cpf' do
      post '/api/user/123/ban'

      expect(response).to be_precondition_failed
      expect(response.body).to include('CPF inválido')
    end
  end
end
