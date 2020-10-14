require 'rails_helper'

feature 'Personal edit profile' do
  scenario 'successfully' do
    personal = create(:personal)

    login_as personal, scope: :personal
    visit root_path
    click_on 'Editar Cadastro'
    fill_in 'Nome', with: 'Joaozinho Aderbal'
    fill_in 'Email', with: 'joaozinho@aderbal.com'
    fill_in 'Senha Atual', with: personal.password
    click_on 'Atualizar Cadastro'

    expect(page).to have_content('A sua conta foi atualizada com sucesso')
    expect(current_path).to eq root_path
  end

  scenario 'must fill password' do
    personal = create(:personal)

    login_as personal, scope: :personal
    visit root_path
    click_on 'Editar Cadastro'
    fill_in 'Nome', with: 'Joaozinho Aderbal'
    fill_in 'Email', with: 'joaozinho@aderbal.com'
    click_on 'Atualizar Cadastro'

    expect(page).to have_content('Senha Atual não pode ficar em branco')
  end

  scenario 'email and name must be filled' do
    personal = create(:personal)

    login_as personal, scope: :personal
    visit root_path
    click_on 'Editar Cadastro'
    fill_in 'Email', with: ''
    fill_in 'Nome', with: ''
    fill_in 'Senha Atual', with: personal.password
    click_on 'Atualizar Cadastro'

    expect(page).to have_content('Email não pode ficar em branco')
    expect(page).to have_content('Nome não pode ficar em branco')
  end
end
