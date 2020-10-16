require 'rails_helper'

feature 'Banned client' do
  before do 
    allow(Subsidiary).to receive(:all)
    .and_return([Subsidiary.new(id: 1, name: 'EspertoII', address: 'Avenida Paulista, 150',
                 cnpj: '11189348000195', token: 'CK4XEB'),
                 Subsidiary.new(id: 1, name: 'Super Esperto', address: 'Avenida Ipiranga, 150',
                                cnpj: '11189348000195', token: 'CK4XEB')])
  end
  
  scenario 'try register client banned' do
    client = build(:client)
    faraday_response = double('cpf_check', status: 200, body: 'true')
    allow(Faraday).to receive(:get).with("http://subsidiaries/api/v1/banned_user/#{CPF.new(client.cpf).stripped}")
                                   .and_return(faraday_response)

    visit new_client_registration_path
    fill_in 'CPF', with: client.cpf
    fill_in 'Email', with: client.email
    fill_in 'Senha', with: client.password
    fill_in 'Confirme sua senha', with: client.password
    click_on 'Cadastrar'

    expect(page).to have_content('Você foi banido')
  end

  scenario 'try login client banned' do
    faraday_response = double('cpf_check', status: 200, body: 'true')
    allow(Faraday).to receive(:get).with('http://subsidiaries/api/v1/banned_user/47814531802')
                                   .and_return(faraday_response)
    client = create(:client, cpf: '478.145.318-02')

    visit new_client_session_path
    fill_in 'CPF', with: client.cpf
    fill_in 'Senha', with: client.password
    click_on 'Log in'

    expect(page).to have_content('Você foi banido')
  end

  scenario 'try register personal trainer banned' do
    personal = build(:personal)
    faraday_response = double('cpf_check', status: 200, body: 'true')
    allow(Faraday).to receive(:get).with("http://subsidiaries/api/v1/banned_user/#{CPF.new(personal.cpf).stripped}")
                                   .and_return(faraday_response)

    visit new_personal_registration_path
    fill_in 'Nome', with: personal.name
    fill_in 'CPF', with: personal.cpf
    fill_in 'CREF', with: personal.cref
    fill_in 'Email', with: personal.email
    fill_in 'Senha', with: personal.password
    fill_in 'Confirmar senha', with: personal.password
    click_on 'Enviar'

    expect(page).to have_content('Você foi banido')
  end

  scenario 'try login personal trainer banned' do
    faraday_response = double('cpf_check', status: 200, body: 'true')
    allow(Faraday).to receive(:get).with('http://subsidiaries/api/v1/banned_user/47814531802')
                                   .and_return(faraday_response)
    personal = create(:personal, cpf: '478.145.318-02')

    visit new_personal_session_path
    fill_in 'CPF', with: personal.cpf
    fill_in 'Senha', with: personal.password
    click_on 'Log in'

    expect(page).to have_content('Você foi banido')
  end
end
