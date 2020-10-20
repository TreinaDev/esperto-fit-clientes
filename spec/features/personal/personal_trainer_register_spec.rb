require 'rails_helper'

feature 'Personal Trainer register' do
  before do
    allow(Subsidiary).to receive(:all)
      .and_return([Subsidiary.new(id: 1, name: 'Vila Maria', address: 'Avenida Osvaldo Reis, 801',
                                  cnpj: '11189348000195', token: 'CK4XEB'),
                   Subsidiary.new(id: 1, name: 'Super Esperto', address: 'Avenida Ipiranga, 150',
                                  cnpj: '11189348000195', token: 'CK4XEB')])
  end

  scenario 'successfully' do
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

  context 'CPF does not need to be formatted' do
    scenario 'can create and log in' do
      visit root_path
      click_on 'Registrar'
      click_on 'aqui'
      fill_in 'Nome', with: 'Alberto'
      fill_in 'Email', with: 'alberto@gmail.com'
      fill_in 'CPF', with: '088-------58754948'
      fill_in 'CREF', with: '001582-G/ES'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmar senha', with: '123456'
      click_on 'Enviar'
      click_on 'Sair'
      click_on 'Entrar'
      click_on 'aqui'
      fill_in 'CPF', with: '08858754948'
      fill_in 'Senha', with: '123456'
      click_on 'Log in'

      expect(current_path).to eq root_path
      expect(page).to have_content('Alberto')
      expect(page).to have_content('com sucesso')
    end

    scenario 'CPF will not be unique' do
      create(:personal, cpf: '088---587-549-4.8')

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

      expect(page).to have_content('CPF já está em uso')
    end
  end
end
