require 'rails_helper'

feature 'Banned client' do
  scenario 'try register client banned' do
    client = build(:client)
    allow(client).to receive(:cpf_get_status).and_return(true)

    visit root_path
    click_on 'Registrar'
    fill_in 'CPF', with: client.cpf
    fill_in 'Email', with: client.email
    fill_in 'Senha', with: client.password
    fill_in 'Confirme sua senha', with: client.password
    click_on 'Cadastrar'

    expect(page).to have_content('Você foi banido e não pode registrar-se')
  end

  scenario 'try login client banned' do
    client = create(:client)
    allow(client).to receive(:cpf_get_status).and_return(true)

    visit root_path
    click_on 'Entrar'
    fill_in 'CPF', with: client.cpf
    fill_in 'Senha', with: client.password
    click_on 'Login'

    expect(page).to have_content('Você foi banido e não pode logar-se')
  end

  scenario 'try register personal trainer banned' do
    personal = build(:personal)
    allow(personal).to receive(:cpf_get_status).and_return(true)

    visit root_path
    click_on 'Registrar Personal Trainer'
    fill_in 'CPF', with: personal.cpf
    fill_in 'CREF', with: personal.cref
    fill_in 'Email', with: personal.email
    fill_in 'Senha', with: personal.password
    fill_in 'Confirme sua senha', with: personal.password
    click_on 'Cadastrar'

    expect(page).to have_content('Você foi banido e não pode registrar-se')
  end

  scenario 'try login personal trainer banned' do
    personal = create(:personal)
    allow(personal).to receive(:cpf_get_status).and_return(true)

    visit root_path
    click_on 'Entrar Personal Trainer'
    fill_in 'CPF', with: personal.cpf
    fill_in 'Senha', with: personal.password
    click_on 'Login'

    expect(page).to have_content('Você foi banido e não pode logar-se')
  end
end
