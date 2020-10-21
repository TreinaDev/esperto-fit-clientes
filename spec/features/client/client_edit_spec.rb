require 'rails_helper'

feature 'Client edit profile' do
  before do
    allow(Subsidiary).to receive(:all)
      .and_return([Subsidiary.new(id: 1, name: 'EspertoII', address: 'Avenida Paulista, 150',
                                  cnpj: '11189348000195', token: 'CK4XEB'),
                   Subsidiary.new(id: 1, name: 'Super Esperto', address: 'Avenida Ipiranga, 150',
                                  cnpj: '11189348000195', token: 'CK4XEB')])
  end

  scenario 'successfully' do
    client = create(:client)

    login_as client, scope: :client
    visit root_path
    click_on 'Editar Cadastro'
    fill_in 'Nome', with: 'Joaozinho Aderbal'
    fill_in 'Email', with: 'joaozinho@aderbal.com'
    fill_in 'Senha Atual', with: client.password
    click_on 'Atualizar Cadastro'

    expect(page).to have_content('A sua conta foi atualizada com sucesso')
    expect(current_path).to eq root_path
  end

  scenario 'must fill password' do
    client = create(:client)

    login_as client, scope: :client
    visit root_path
    click_on 'Editar Cadastro'
    fill_in 'Nome', with: 'Joaozinho Aderbal'
    fill_in 'Email', with: 'joaozinho@aderbal.com'
    click_on 'Atualizar Cadastro'

    expect(page).to have_content('Senha Atual não pode ficar em branco')
  end

  scenario 'email must be filled' do
    client = create(:client)

    login_as client, scope: :client
    visit root_path
    click_on 'Editar Cadastro'
    fill_in 'Email', with: ''
    fill_in 'Senha Atual', with: client.password
    click_on 'Atualizar Cadastro'

    expect(page).to have_content('Email não pode ficar em branco')
  end
end
