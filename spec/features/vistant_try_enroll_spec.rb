require 'rails_helper'

feature 'visitant try enroll' do
  scenario 'and must be signed up' do
    subsidiary = Subsidiary.new(id: 1, name: 'Vila Maria', address: 'Avenida Osvaldo Reis, 801',
                                cnpj: '11189348000195', token: 'CK4XEB')
    allow(Subsidiary).to receive(:all).and_return([subsidiary])

    visit root_path
    click_on subsidiary.name
    click_on 'Matricule-se agora'

    expect(current_path).to eq client_session_path
  end

  scenario 'and has a enroll' do
    faraday_response = double('cpf_check', status: 200, body: 'false')
    allow(Faraday).to receive(:get).with('http://subsidiaries/api/v1/banned_user/47814531802')
                                   .and_return(faraday_response)
    client = create(:client, cpf: '478.145.318-02')
    payment_option = create(:payment_option)
    subsidiary = Subsidiary.new(id: 1, name: 'Vila Maria', address: 'Avenida Osvaldo Reis, 801',
                                cnpj: '11189348000195', token: 'CK4XEB')
    plan = Plan.new(id: 1, name: 'Black', monthly_payment: 120.00, permanency: 12,
                    subsidiary: subsidiary)
    Enroll.create(subsidiary_id: subsidiary.id, plan_id: plan.id,
                  client_id: client.id, payment_option_id: payment_option.id)
    allow(Subsidiary).to receive(:all).and_return([subsidiary])
    allow(subsidiary).to receive(:plans).and_return([plan])

    login_as client, scope: :client
    visit root_path
    click_on subsidiary.name

    expect(page).to_not have_link('Matricule-se agora')
  end

  scenario 'sucessfully' do
    faraday_response = double('cpf_check', status: 200, body: 'false')
    allow(Faraday).to receive(:get).with('http://subsidiaries/api/v1/banned_user/47814531802')
                                   .and_return(faraday_response)
    client = create(:client, cpf: '478.145.318-02')
    subsidiary = Subsidiary.new(id: 1, name: 'Vila Maria', address: 'Avenida Osvaldo Reis, 801',
                                cnpj: '11189348000195', token: 'CK4XEB')
    allow(Subsidiary).to receive(:all).and_return([subsidiary])
    allow(subsidiary).to receive(:plans).and_return([])

    login_as client, scope: :client
    visit root_path
    click_on subsidiary.name
    click_on 'Matricule-se agora'

    expect(current_path).to eq new_subsidiary_enroll_path(subsidiary.id)
  end

  scenario 'and must be signed to access new path' do
    subsidiary = Subsidiary.new(id: 1, name: 'Vila Maria', address: 'Avenida Osvaldo Reis, 801',
                                cnpj: '11189348000195', token: 'CK4XEB')
    allow(Subsidiary).to receive(:all).and_return([subsidiary])

    visit new_subsidiary_enroll_path(subsidiary.id)

    expect(current_path).to eq client_session_path
  end

  scenario 'and already enrolled to access new path' do
    faraday_response = double('cpf_check', status: 200, body: 'false')
    allow(Faraday).to receive(:get).with('http://subsidiaries/api/v1/banned_user/47814531802')
                                   .and_return(faraday_response)
    client = create(:client, cpf: '478.145.318-02')
    payment_option = create(:payment_option)
    subsidiary = Subsidiary.new(id: 1, name: 'Vila Maria', address: 'Avenida Osvaldo Reis, 801',
                                cnpj: '11189348000195', token: 'CK4XEB')
    plan = Plan.new(id: 1, name: 'Black', monthly_payment: 120.00, permanency: 12,
                    subsidiary: subsidiary)
    Enroll.create(subsidiary_id: subsidiary.id, plan_id: plan.id,
                  client_id: client.id, payment_option_id: payment_option.id)
    allow(Subsidiary).to receive(:all).and_return([subsidiary])
    allow(subsidiary).to receive(:plans).and_return([plan])

    login_as client, scope: :client
    visit new_subsidiary_enroll_path(subsidiary.id)

    expect(page).to have_content('Você já está matriculado em uma unidade')
  end
end
