require 'rails_helper'

feature 'client enroll a subsidiary' do
  scenario 'and view details summary' do
    client = create(:client)
    payment_option = create(:payment_option)
    subsidiary = Subsidiary.new(id: 1, name: 'Vila Maria',
                                address: 'Avenida Osvaldo Reis, 801', cep: '88306-773')
    plan = Plan.new(id: 1, name: 'Black', monthly_payment: 120.00, permanency: 12,
                    subsidiary: subsidiary)
    allow(Subsidiary).to receive(:all).and_return([subsidiary])
    allow(subsidiary).to receive(:plans).and_return([plan])

    login_as client, scope: :client
    visit root_path
    click_on subsidiary.name
    click_on 'Matricule-se agora'
    select 'Black - R$ 120,00', from: 'Plano'
    select payment_option.name, from: 'Forma de pagamento'
    click_on 'Próximo'

    expect(page).to have_content(client.cpf)
    expect(page).to have_content(client.email)
    expect(page).to have_content(plan.name)
    expect(page).to have_content('Boleto')
    expect(page).to have_content("#{plan.permanency} meses")
    expect(page).to have_content('R$ 120,00')
    expect(page).to have_link('Confirmar')
    expect(page).to have_link('Voltar')
  end

  scenario 'sucessfully' do
    client = create(:client)
    payment_option = create(:payment_option)
    subsidiary = Subsidiary.new(id: 1, name: 'Vila Maria',
                                address: 'Avenida Osvaldo Reis, 801', cep: '88306-773')
    plan = Plan.new(id: 1, name: 'Black', monthly_payment: 120.00, permanency: 12,
                    subsidiary: subsidiary)
    allow(Subsidiary).to receive(:all).and_return([subsidiary])
    allow(subsidiary).to receive(:plans).and_return([plan])

    login_as client, scope: :client
    visit root_path
    click_on subsidiary.name
    click_on 'Matricule-se agora'
    select 'Black - R$ 120,00', from: 'Plano'
    select payment_option.name, from: 'Forma de pagamento'
    click_on 'Próximo'
    click_on 'Confirmar'

    expect(page).to have_content('Matricula realizada com sucesso')
  end

  scenario 'not must fill in blank' do
    client = create(:client)
    subsidiary = Subsidiary.new(id: 1, name: 'Vila Maria',
                                address: 'Avenida Osvaldo Reis, 801', cep: '88306-773')
    plan = Plan.new(id: 1, name: 'Black', monthly_payment: 120.00, permanency: 12,
                    subsidiary: subsidiary)
    allow(Subsidiary).to receive(:all).and_return([subsidiary])
    allow(subsidiary).to receive(:plans).and_return([plan])

    login_as client, scope: :client
    visit root_path
    click_on subsidiary.name
    click_on 'Matricule-se agora'
    click_on 'Próximo'

    expect(page).to have_content('não pode ficar em branco', count: 1)
    expect(page).to have_content('é obrigatório(a)', count: 1)
  end

  scenario 'and return to enroll form' do
    client = create(:client)
    payment_option = create(:payment_option)
    subsidiary = Subsidiary.new(id: 1, name: 'Vila Maria',
                                address: 'Avenida Osvaldo Reis, 801', cep: '88306-773')
    plan = Plan.new(id: 1, name: 'Black', monthly_payment: 120.00, permanency: 12,
                    subsidiary: subsidiary)
    allow(Subsidiary).to receive(:all).and_return([subsidiary])
    allow(subsidiary).to receive(:plans).and_return([plan])

    login_as client, scope: :client
    visit root_path
    click_on subsidiary.name
    click_on 'Matricule-se agora'
    select 'Black - R$ 120,00', from: 'Plano'
    select payment_option.name, from: 'Forma de pagamento'
    click_on 'Próximo'
    click_on 'Voltar'

    expect(current_path).to eq new_subsidiary_enroll_path(subsidiary.id)
  end
end
