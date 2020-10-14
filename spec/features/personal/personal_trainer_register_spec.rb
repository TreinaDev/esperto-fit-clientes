require 'rails_helper'

feature 'Personal Trainer register' do
  scenario 'successfully' do
    faraday_response = double('cpf_check', status: 200, body: 'false')
    allow(Faraday).to receive(:get).and_return(faraday_response)

    visit root_path
    click_on 'Registrar'
    click_on 'aqui'
    fill_in 'Nome', with: 'Alberto'
    fill_in 'Email', with: 'alberto@gmail.com'
    fill_in 'CPF', with: '08858754948'
    fill_in 'CREF', with: '001582-G/ES'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmar senha', with: '123456'
    click_on 'Enviar'

    expect(current_path).to eq root_path
    expect(page).to have_content('Alberto')
    expect(page).to have_content('com sucesso')
  end

  scenario 'did not fill all the fields' do
    visit root_path
    click_on 'Registrar'
    click_on 'aqui'
    click_on 'Enviar'

    expect(current_path).to_not eq root_path
    expect(page).to have_content('Email não pode ficar em branco')
    expect(page).to have_content('Senha não pode ficar em branco')
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('CREF não pode ficar em branco')
    expect(page).to have_content('CPF não pode ficar em branco')
  end

  scenario 'CPF must be valid' do
    visit root_path
    click_on 'Registrar'
    click_on 'aqui'
    fill_in 'CPF', with: '99442568'
    click_on 'Enviar'

    expect(current_path).to_not eq root_path
    expect(page).to have_content('CPF não é válido')
  end

  scenario 'CREF must be valid' do
    visit root_path
    click_on 'Registrar'
    click_on 'aqui'
    fill_in 'CREF', with: '123'
    click_on 'Enviar'

    expect(current_path).to_not eq root_path
    expect(page).to have_content('CREF não é válido')
  end
end
