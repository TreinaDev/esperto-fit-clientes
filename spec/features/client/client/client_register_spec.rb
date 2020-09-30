require 'rails_helper'

feature 'Visitor creates Account' do
  scenario 'successfully' do
    visit root_path
    click_on 'Registrar'
    fill_in 'CPF', with: '082.923.869-71'
    fill_in 'Email', with: 'test@email.com'
    fill_in 'Senha', with: '12345678'
    fill_in 'Confirmar senha', with: '12345678'
    click_on 'Registrar'

    expect(Client.all.count).to eq(1)
    expect(page).to have_content('Bem vindo! Você realizou seu registro com sucesso.')
  end

  scenario 'must fill all fields' do
    visit new_client_registration_path
    fill_in 'CPF', with: ''
    fill_in 'Email', with: ''
    fill_in 'Senha', with: ''
    click_on 'Registrar'

    expect(page).to have_content('não pode ficar em branco', count: 3)
    expect(page).to have_content('Email não pode ficar em branco')
    expect(page).to have_content('CPF não pode ficar em branco')
    expect(page).to have_content('Senha não pode ficar em branco')
  end

  scenario 'cpf must be valid' do
    visit new_client_registration_path
    fill_in 'CPF', with: '333.333.333-33'
    fill_in 'Email', with: 'test@email.com'
    fill_in 'Senha', with: '12345678'
    fill_in 'Confirmar senha', with: '12345678'
    click_on 'Registrar'

    expect(page).to have_content('CPF precisa ser válido')
  end
end
