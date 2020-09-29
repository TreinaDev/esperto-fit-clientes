require 'rails_helper'

feature 'client enroll a subsidiary' do
  scenario 'sucessfully logged in' do
    client = create(:client)
    subsidiary = Subsidiary.new(id: 1, name: 'Vila Maria', address: 'Avenida Osvaldo Reis, 801', cep: '88306-773')
    allow(Subsidiary).to receive(:all).and_return([subsidiary])

    login_as(client)
    visit root_path
    click_on subsidiary.name
    click_on 'Matricule-se agora'
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
    expect(page).to have_content('Confirmar')
    expect(page).to have_content('Voltar')
    # Plano: preco mensal, nome, permanencia minima, status
  end

  xscenario 'not logged in' do
  end

  xscenario 'not must fill in blank' do
  end

  xscenario 'already enrolled' do
  end
end
