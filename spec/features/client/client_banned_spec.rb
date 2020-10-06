require 'rails_helper'

feature 'Banned client' do
  scenario 'try to register banned' do
    client = build(:client)
    allow(Client).to receive(:cpf_ban?).and_return(true)

    visit root_path
    click_on 'Registrar'
    fill_in 'CPF', with: client.cpf
    fill_in 'Email', with: client.email
    fill_in 'Senha', with: client.password
    fill_in 'Confirme sua senha', with: client.password
    click_on 'Cadastrar'

    expect(page).to have_content('Você foi banido e não pode registrar-se')
  end

  scenario 'try login banned' do
    client = create(:client)
    allow(Client).to receive(:cpf_ban?).and_return(true)

    visit root_path
    click_on 'Entrar'
    fill_in 'CPF', with: client.cpf
    fill_in 'Email', with: client.email
    fill_in 'Senha', with: client.password
    click_on 'Login'

    expect(page).to have_content('Você foi banido e não pode logar-se')
  end
end
