require 'rails_helper'

feature 'Visitor creates Account' do
  scenario 'successfully' do
    faraday_response = double('cpf_check', status: 200, body: 'false')
    allow(Faraday).to receive(:get).and_return(faraday_response)

    visit root_path
    click_on 'Registrar'
    fill_in 'CPF', with: '082.923.869-71'
    fill_in 'Email', with: 'test@email.com'
    fill_in 'Senha', with: '12345678'
    fill_in 'Confirme sua senha', with: '12345678'
    click_on 'Cadastrar'

    expect(page).to have_content('Bem vindo! Você realizou seu registro com sucesso.')
    expect(page).to_not have_link('Entrar')
    expect(page).to_not have_link('Registrar',
                                  href: new_client_registration_path)
    expect(page).to have_link('Sair')
  end

  scenario 'must fill all fields' do
    visit new_client_registration_path
    fill_in 'CPF', with: ''
    fill_in 'Email', with: ''
    fill_in 'Senha', with: ''
    click_on 'Cadastrar'

    expect(page).to have_content('Email não pode ficar em branco')
    expect(page).to have_content('CPF não pode ficar em branco')
    expect(page).to have_content('Senha não pode ficar em branco')
  end

  scenario 'cpf must be valid' do
    visit new_client_registration_path
    fill_in 'CPF', with: '333.333.333-33'
    fill_in 'Email', with: 'test@email.com'
    fill_in 'Senha', with: '12345678'
    fill_in 'Confirme sua senha', with: '12345678'
    click_on 'Cadastrar'

    expect(page).to have_content('CPF precisa ser válido')
  end

  scenario 'cpf must be uniq' do
    faraday_response = double('cpf_check', status: 200, body: 'false')
    allow(Faraday).to receive(:get).and_return(faraday_response)
    create(:client, cpf: '082.923.869-71')
    visit new_client_registration_path
    fill_in 'CPF', with: '082.923.869-71'
    fill_in 'Email', with: 'test@email.com'
    fill_in 'Senha', with: '12345678'
    fill_in 'Confirme sua senha', with: '12345678'
    click_on 'Cadastrar'

    expect(page).to have_content('CPF já está em uso')
  end
end
