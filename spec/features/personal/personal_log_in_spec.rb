require 'rails_helper'

feature 'Personal login on system' do
  scenario 'successfully' do
    faraday_response = double('cpf_check', status: 200, body: 'false')
    allow(Faraday).to receive(:get).and_return(faraday_response)
    personal = create(:personal)

    visit root_path
    click_on 'Entrar'
    click_on 'aqui'
    fill_in 'CPF', with: personal.cpf
    fill_in 'Senha', with: personal.password
    click_on 'Log in'

    expect(page).to have_content('Login efetuado com sucesso')
    expect(page).to_not have_link('Entrar')
    expect(page).to_not have_link('Registrar')
    expect(page).to have_link('Sair')
  end

  scenario 'personal failed to login' do
    faraday_response = double('cpf_check', status: 200, body: 'false')
    allow(Faraday).to receive(:get).and_return(faraday_response)
    personal = create(:personal)

    visit root_path
    click_on 'Entrar'
    click_on 'aqui'
    fill_in 'CPF', with: ''
    fill_in 'Senha', with: personal.password
    click_on 'Log in'

    expect(page).to have_content('CPF ou senha inválidos.')
  end

  scenario 'and log out' do
    faraday_response = double('cpf_check', status: 200, body: 'false')
    allow(Faraday).to receive(:get).and_return(faraday_response)
    personal = create(:personal)

    login_as personal, scope: :personal
    visit root_path
    click_on 'Sair'

    expect(page).to have_content('Logout efetuado com sucesso')
  end
end
