require 'rails_helper'

feature 'Client login on system' do
  before do
    allow(Subsidiary).to receive(:all)
      .and_return([Subsidiary.new(id: 1, name: 'EspertoII', address: 'Avenida Paulista, 150',
                                  cnpj: '11189348000195', token: 'CK4XEB'),
                   Subsidiary.new(id: 1, name: 'Super Esperto', address: 'Avenida Ipiranga, 150',
                                  cnpj: '11189348000195', token: 'CK4XEB')])
  end

  scenario 'successfully' do
    faraday_response = double('cpf_check', status: 404)
    allow(Faraday).to receive(:get).and_return(faraday_response)
    client = create(:client)

    visit root_path
    click_on 'Entrar'
    fill_in 'CPF', with: client.cpf
    fill_in 'Senha', with: client.password
    click_on 'Log in'

    expect(page).to have_content('Login efetuado com sucesso')
    expect(page).to_not have_link('Entrar')
    expect(page).to_not have_link('Registrar',
                                  href: new_client_registration_path)
    expect(page).to have_link('Sair')
  end

  scenario 'client failed to login' do
    faraday_response = double('cpf_check', status: 404)
    allow(Faraday).to receive(:get).and_return(faraday_response)
    client = create(:client)

    visit root_path
    click_on 'Entrar'
    fill_in 'CPF', with: ''
    fill_in 'Senha', with: client.password
    click_on 'Log in'

    expect(page).to have_content('CPF ou senha inválidos.')
  end

  scenario 'and log out' do
    faraday_response = double('cpf_check', status: 404)
    allow(Faraday).to receive(:get).and_return(faraday_response)
    client = create(:client)
    login_as client, scope: :client

    visit root_path
    click_on 'Sair'

    expect(page).to have_content('Logout efetuado com sucesso')
  end
end
