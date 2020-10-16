require 'rails_helper'

feature 'Breadcrumbs' do
  before do
    allow(Subsidiary).to receive(:all)
      .and_return([Subsidiary.new(id: 1, name: 'Vila Maria', address: 'Avenida Osvaldo Reis, 801',
                                  cnpj: '11189348000195', token: 'CK4XEB'),
                   Subsidiary.new(id: 1, name: 'Super Esperto', address: 'Avenida Ipiranga, 150',
                                  cnpj: '11189348000195', token: 'CK4XEB')])
  end
  context 'subsidiaries and enroll' do
    scenario 'show' do
      visit root_path
      click_on 'Vila Maria'

      expect(page).to have_link('Home', href: root_path)
      expect(page).to have_content('Home Vila Maria')
      expect(page).to_not have_content('Home Matrícula')
    end

    scenario 'search' do
      visit root_path
      click_on 'Buscar'

      expect(page).to have_link('Home', href: root_path)
      expect(page).to have_content('Home Busca')
      expect(page).to_not have_content('Home Vila Maria')
    end

    scenario 'enroll' do
      faraday_response = double('cpf_check', status: 200, body: 'false')
      allow(Faraday).to receive(:get).and_return(faraday_response)
      subsidiary = Subsidiary.new(id: 1, name: 'Vila Maria', address: 'Avenida Osvaldo Reis, 801',
                                  cnpj: '11189348000195', token: 'CK4XEB')
      plan = Plan.new(id: 1, name: 'Black', monthly_payment: 120.00, permanency: 12,
                      subsidiary: subsidiary)
      allow(Subsidiary).to receive(:all).and_return([subsidiary])
      allow(subsidiary).to receive(:plans).and_return([plan])
      client = create(:client)

      login_as(client, scope: :client)
      visit root_path
      click_on subsidiary.name
      click_on 'Matricule-se'

      expect(page).to have_link('Home', href: root_path)
      expect(page).to have_link('Vila Maria')
      expect(page).to have_content('Home Vila Maria Matrícula')
      expect(page).to_not have_content('Home Busca')
    end

    scenario 'confirm enroll' do
      faraday_response = double('cpf_check', status: 200, body: 'false')
      allow(Faraday).to receive(:get).and_return(faraday_response)
      client = create(:client)
      create(:payment_option)
      subsidiary = Subsidiary.new(id: 1, name: 'Vila Maria', address: 'Avenida Osvaldo Reis, 801',
                                  cnpj: '11189348000195', token: 'CK4XEB')
      plan = Plan.new(id: 1, name: 'Black', monthly_payment: 120.00, permanency: 12,
                      subsidiary: subsidiary)
      allow(Subsidiary).to receive(:all).and_return([subsidiary])
      allow(subsidiary).to receive(:plans).and_return([plan])

      login_as(client, scope: :client)
      visit root_path
      click_on subsidiary.name
      click_on 'Matricule-se'
      select plan.name, from: 'Plano'
      select 'Boleto', from: 'Forma de pagamento'
      click_on 'Próximo'

      expect(page).to have_link('Home', href: root_path)
      expect(page).to have_link('Vila Maria', href: subsidiary_path(subsidiary.id))
      expect(page).to have_link('Matrícula', href: new_subsidiary_enroll_path(subsidiary.id))
      expect(page).to have_content('Home Vila Maria Matrícula Confirmar')
      expect(page).to_not have_content('Home Busca')
    end
  end
end
