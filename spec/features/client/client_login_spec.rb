require 'rails_helper'

feature 'Client login on system' do
  scenario 'successfully' do
    cliente = create(:client)
    visit root_path
    click_on 'Entrar'
    fill_in 'CPF', with: cliente.cpf
    fill_in 'Senha', with: cliente.password
    click_on 'Login'

    expect(page).to have_content('Login efetuado com sucesso')
  end

  scenario 'client failed to login' do
    cliente = create(:client)
    visit root_path
    click_on 'Entrar'
    fill_in 'CPF', with: ''
    fill_in 'Senha', with: cliente.password
    click_on 'Login'

    expect(page).to have_content('CPF ou senha inválidos.')
  end
end
