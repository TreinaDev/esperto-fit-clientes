require 'rails_helper'

describe 'Enroll subsidiary' do
  context 'confirm' do
    let(:subsidiary) do
      Subsidiary.new(id: 1, name: 'Vila Maria', address: 'Avenida Osvaldo Reis, 801',
                     cnpj: '11189348000195', token: 'CK4XEB')
    end

    it 'must be logged in to post confirm' do
      post subsidiary_enrolls_confirm_path(subsidiary.id)

      expect(response).to redirect_to(new_client_session_path)
    end

    it 'with invalid params' do
      faraday_response = double('cpf_check', status: 200, body: 'false')
      allow(Faraday).to receive(:get).with('http://subsidiaries/api/v1/banned_user/47814531802')
                                     .and_return(faraday_response)
      client = create(:client, cpf: '478.145.318-02')
      allow(Subsidiary).to receive(:all).and_return([subsidiary])
      allow(subsidiary).to receive(:plans).and_return([])

      login_as client, scope: :client
      post subsidiary_enrolls_confirm_path(subsidiary.id), params: { enroll: { teste: 'teste' } }

      expect(response).to render_template(:new)
    end

    it 'with invalid subsidiary_id' do
      faraday_response = double('cpf_check', status: 200, body: 'false')
      allow(Faraday).to receive(:get).with('http://subsidiaries/api/v1/banned_user/47814531802')
                                     .and_return(faraday_response)
      client = create(:client, cpf: '478.145.318-02')
      allow(Subsidiary).to receive(:all).and_return([subsidiary])

      login_as client, scope: :client
      post subsidiary_enrolls_confirm_path(2), params: { enroll: { teste: 'teste' } }

      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include('Filial não encontrada')
    end

    it 'with valid params' do
      faraday_response = double('cpf_check', status: 200, body: 'false')
      allow(Faraday).to receive(:get).with('http://subsidiaries/api/v1/banned_user/47814531802')
                                     .and_return(faraday_response)
      client = create(:client, cpf: '478.145.318-02')
      payment_option = create(:payment_option)
      plan = Plan.new(id: 1, name: 'Black', monthly_payment: 120.00, permanency: 12,
                      subsidiary: subsidiary)
      enroll = Enroll.new(subsidiary_id: subsidiary.id, plan_id: plan.id,
                          payment_option_id: payment_option.id)

      allow(Subsidiary).to receive(:all).and_return([subsidiary])
      allow(subsidiary).to receive(:plans).and_return([plan])

      login_as client, scope: :client

      post subsidiary_enrolls_confirm_path(subsidiary.id), params: { enroll: enroll.attributes }

      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Confirmar')
    end
  end

  context 'create' do
    let(:subsidiary) do
      Subsidiary.new(id: 1, name: 'Vila Maria', address: 'Avenida Osvaldo Reis, 801',
                     cnpj: '11189348000195', token: 'CK4XEB')
    end
    it 'must be logged in to post create' do
      post enrolls_path, params: { enroll: { teste: 'teste' } }

      expect(response).to redirect_to(new_client_session_path)
    end

    it 'with invalid params and valid subsidiary_id' do
      faraday_response = double('cpf_check', status: 200, body: 'false')
      allow(Faraday).to receive(:get).with('http://subsidiaries/api/v1/banned_user/47814531802')
                                     .and_return(faraday_response)
      client = create(:client, cpf: '478.145.318-02')
      allow(Subsidiary).to receive(:all).and_return([subsidiary])
      allow(subsidiary).to receive(:plans).and_return([])

      login_as client, scope: :client
      post enrolls_path, params: { enroll: { teste: 'teste', subsidiary_id: subsidiary.id } }

      expect(response).to render_template(:new)
    end

    it 'with invalid subsidiary_id' do
      faraday_response = double('cpf_check', status: 200, body: 'false')
      allow(Faraday).to receive(:get).with('http://subsidiaries/api/v1/banned_user/47814531802')
                                     .and_return(faraday_response)
      client = create(:client, cpf: '478.145.318-02')
      allow(Subsidiary).to receive(:all).and_return([subsidiary])

      login_as client, scope: :client
      post enrolls_path, params: { enroll: { teste: 'teste' } }

      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include('Filial não encontrada')
    end

    it 'with valid params' do
      faraday_response = double('cpf_check', status: 200, body: 'false')
      allow(Faraday).to receive(:get).with('http://subsidiaries/api/v1/banned_user/47814531802')
                                     .and_return(faraday_response)
      client = create(:client, cpf: '478.145.318-02')
      payment_option = create(:payment_option)
      plan = Plan.new(id: 1, name: 'Black', monthly_payment: 120.00, permanency: 12,
                      subsidiary: subsidiary)
      enroll = Enroll.new(subsidiary_id: subsidiary.id, plan_id: plan.id,
                          payment_option_id: payment_option.id, client_id: client.id)

      allow(Subsidiary).to receive(:all).and_return([subsidiary])
      allow(subsidiary).to receive(:plans).and_return([])

      login_as client, scope: :client

      post enrolls_path(subsidiary.id), params: { enroll: enroll.attributes }

      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include('Matricula realizada com sucesso')
    end
  end
end
