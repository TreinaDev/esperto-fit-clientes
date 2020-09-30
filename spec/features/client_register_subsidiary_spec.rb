require 'rails_helper'

feature 'client enroll a subsidiary' do
  scenario 'and view details summary' do
    client = create(:client, name: '', cpf: '', address: '')
    subsidiary = Subsidiary.new(id: 1, name: 'Vila Maria', address: 'Avenida Osvaldo Reis, 801', cep: '88306-773')
    allow(Subsidiary).to receive(:all).and_return([subsidiary])

    login_as(client)
    visit root_path
    click_on subsidiary.name
    click_on 'Matricule-se agora'
    fill_in 'Nome', with: 'João'
    fill_in 'CPF', with: '753.983.030-15'
    fill_in 'Endereço', with: 'Rua Salvado Simoes'
    select 'Black', from: 'Selecione seu plano'
    select 'Boleto', from: 'Forma de pagamento'
    click_on 'Próximo'

    expect(page).to have_content(client.name)
    expect(page).to have_content(client.cpf)
    expect(page).to have_content(client.email)
    expect(page).to have_content(client.address)
    expect(page).to have_content('Black')
    expect(page).to have_content('Boleto')
    expect(page).to have_content('Permanncia minima: 12 meses')
    expect(page).to have_content('59,90')
    expect(page).to have_link('Confirmar')
    expect(page).to have_link('Voltar')
    # Plano: preco mensal, nome, permanencia minima, status
  end

  scenario 'sucessfully' do
    client = create(:client, name: '', cpf: '', address: '')
    subsidiary = Subsidiary.new(id: 1, name: 'Vila Maria', address: 'Avenida Osvaldo Reis, 801', cep: '88306-773')
    allow(Subsidiary).to receive(:all).and_return([subsidiary])

    login_as(client)
    visit root_path
    click_on subsidiary.name
    click_on 'Matricule-se agora'
    fill_in 'Nome', with: 'João'
    fill_in 'CPF', with: '753.983.030-15'
    fill_in 'Endereço', with: 'Rua Salvado Simoes'
    select 'Black', from: 'Selecione seu plano'
    select 'Boleto', from: 'Forma de pagamento'
    click_on 'Próximo'
    click_on 'Confirmar'

    expect(page).to have_content('Matricula realizada com sucesso')
  end

  scenario 'not must fill in blank' do
    client = create(:client, name: '', cpf: '', address: '')
    subsidiary = Subsidiary.new(id: 1, name: 'Vila Maria', address: 'Avenida Osvaldo Reis, 801', cep: '88306-773')
    allow(Subsidiary).to receive(:all).and_return([subsidiary])

    login_as(client)
    visit root_path
    click_on subsidiary.name
    click_on 'Matricule-se agora'
    click_on 'Próximo'

    expect(page).to have_content('não pode ficar em branco', count: 5)
  end

  scenario 'and return to form register' do
    client = create(:client, name: '', cpf: '', address: '')
    subsidiary = Subsidiary.new(id: 1, name: 'Vila Maria', address: 'Avenida Osvaldo Reis, 801', cep: '88306-773')
    allow(Subsidiary).to receive(:all).and_return([subsidiary])

    login_as(client)
    visit root_path
    click_on subsidiary.name
    click_on 'Matricule-se agora'
    fill_in 'Nome', with: 'João'
    fill_in 'CPF', with: '753.983.030-15'
    fill_in 'Endereço', with: 'Rua Salvado Simoes'
    select 'Black', from: 'Selecione seu plano'
    select 'Boleto', from: 'Forma de pagamento'
    click_on 'Próximo'
    click_on 'Voltar'

    expect(current_path).to eq new_enroll_path(subsidiary.id)
  end
end
