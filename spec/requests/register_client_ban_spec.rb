require 'rails_helper'

describe 'Ban user' do
  context 'GET /api/user/:user_cpf/ban' do
    context 'with valid parameters' do
      it 'return 200 status if user have client account' do
        faraday_response = double('cpf_check', status: 200, body: 'false')
        allow(Faraday).to receive(:get).with('http://subsidiaries/api/v1/banned_user/47814531802')
                                       .and_return(faraday_response)
        create(:client, cpf: '478.145.318-02')

        post '/api/user/47814531802/ban'

        expect(response).to be_ok
        expect(response.body).to include('Cliente banido com sucesso')
      end

      it 'return 200 status if user have personal account' do
        faraday_response = double('cpf_check', status: 200, body: 'false')
        allow(Faraday).to receive(:get).with('http://subsidiaries/api/v1/banned_user/47814531802')
                                       .and_return(faraday_response)
        create(:personal, cpf: '478.145.318-02')

        post '/api/user/47814531802/ban'

        expect(response).to be_ok
        expect(response.body).to include('Personal Trainer banido com sucesso')
      end

      it 'return 200 if client already banned' do
        faraday_response = double('cpf_check', status: 200, body: 'true')
        allow(Faraday).to receive(:get).with('http://subsidiaries/api/v1/banned_user/47814531802')
                                       .and_return(faraday_response)
        create(:client, cpf: '478.145.318-02')

        post '/api/user/47814531802/ban'

        expect(response).to be_ok
        expect(response.body).to include('Cliente já banido anteriormente')
      end

      it 'return 200 if personal already banned' do
        faraday_response = double('cpf_check', status: 200, body: 'true')
        allow(Faraday).to receive(:get).with('http://subsidiaries/api/v1/banned_user/47814531802')
                                       .and_return(faraday_response)
        create(:personal, cpf: '478.145.318-02')

        post '/api/user/47814531802/ban'

        expect(response).to be_ok
        expect(response.body).to include('Personal Trainer já banido anteriormente')
      end

      it 'return 404 if user dont have account' do
        post '/api/user/08858754948/ban'

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
