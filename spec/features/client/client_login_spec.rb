require 'rails_helper'

feature 'Client login on system' do
  scenario 'successfully' do
    faraday_response = double('cpf_check', status: 200, body: 'false')
    allow(Faraday).to receive(:get).with('http://subsidiaries/api/v1/banned_user/47814531802')
                                   .and_return(faraday_response)
    client = create(:client, cpf: '478.145.318-02')

    visit root_path
    click_on 'Entrar'
    fill_in 'CPF', with: client.cpf
    fill_in 'Senha', with: client.password
    click_on 'Login'

    expect(page).to have_content('Login efetuado com sucesso')
    expect(page).to_not have_link('Entrar')
    expect(page).to_not have_link('Registrar')
    expect(page).to have_link('Sair')
  end

  scenario 'client failed to login' do
    faraday_response = double('cpf_check', status: 200, body: 'false')
    allow(Faraday).to receive(:get).with('http://subsidiaries/api/v1/banned_user/47814531802')
                                   .and_return(faraday_response)
    client = create(:client, cpf: '478.145.318-02')

    visit root_path
    click_on 'Entrar'
    fill_in 'CPF', with: ''
    fill_in 'Senha', with: client.password
    click_on 'Login'

    expect(page).to have_content('CPF ou senha inválidos.')
  end

  scenario 'and log out' do
    faraday_response = double('cpf_check', status: 200, body: 'false')
    allow(Faraday).to receive(:get).with('http://subsidiaries/api/v1/banned_user/47814531802')
                                   .and_return(faraday_response)
    client = create(:client, cpf: '478.145.318-02')
    login_as client, scope: :client

    visit root_path
    click_on 'Sair'

    expect(page).to have_content('Logout efetuado com sucesso')
  end
end
