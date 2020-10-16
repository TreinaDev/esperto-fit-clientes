require 'rails_helper'

feature 'Personal edit profile' do
  before do
    allow(Subsidiary).to receive(:all)
      .and_return([Subsidiary.new(id: 1, name: 'Vila Maria', address: 'Avenida Osvaldo Reis, 801',
                                  cnpj: '11189348000195', token: 'CK4XEB'),
                   Subsidiary.new(id: 1, name: 'Super Esperto', address: 'Avenida Ipiranga, 150',
                                  cnpj: '11189348000195', token: 'CK4XEB')])
  end

  scenario 'successfully' do
    faraday_response = double('cpf_check', status: 200, body: 'false')
    allow(Faraday).to receive(:get).and_return(faraday_response)
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
    faraday_response = double('cpf_check', status: 200, body: 'false')
    allow(Faraday).to receive(:get).and_return(faraday_response)
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
    faraday_response = double('cpf_check', status: 200, body: 'false')
    allow(Faraday).to receive(:get).and_return(faraday_response)
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
