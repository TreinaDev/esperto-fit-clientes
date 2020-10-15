require 'rails_helper'

feature 'visitant try enroll' do
  scenario 'and must be signed up' do
    subsidiary = Subsidiary.new(id: 1, name: 'Vila Maria',
                                address: 'Avenida Osvaldo Reis, 801', cep: '88306-773')
    allow(Subsidiary).to receive(:all).and_return([subsidiary])

    visit root_path
    click_on subsidiary.name
    click_on 'Matricule-se agora'

    expect(current_path).to eq client_session_path
  end

  scenario 'and has a enroll' do
    client = create(:client)
    payment_option = create(:payment_option)
    subsidiary = Subsidiary.new(id: 1, name: 'Vila Maria',
                                address: 'Avenida Osvaldo Reis, 801', cep: '88306-773')
    plan = Plan.new(id: 1, name: 'Black', monthly_payment: 120.00, permanency: 12,
                    subsidiary: subsidiary)
    Enroll.create(subsidiary_id: subsidiary.id, plan_id: plan.id,
                  client_id: client.id, payment_option_id: payment_option.id)
    allow(Subsidiary).to receive(:all).and_return([subsidiary])
    allow(Plan).to receive(:all).and_return([plan])

    login_as client, scope: :client
    visit root_path
    click_on subsidiary.name

    expect(page).to_not have_link('Matricule-se agora')
  end

  scenario 'sucessfully' do
    client = create(:client)
    subsidiary = Subsidiary.new(id: 1, name: 'Vila Maria',
                                address: 'Avenida Osvaldo Reis, 801', cep: '88306-773')
    allow(Subsidiary).to receive(:all).and_return([subsidiary])

    login_as client, scope: :client
    visit root_path
    click_on subsidiary.name
    click_on 'Matricule-se agora'

    expect(current_path).to eq new_subsidiary_enroll_path(subsidiary.id)
  end

  scenario 'and must be signed to access new path' do
    subsidiary = Subsidiary.new(id: 1, name: 'Vila Maria',
                                address: 'Avenida Osvaldo Reis, 801', cep: '88306-773')
    allow(Subsidiary).to receive(:all).and_return([subsidiary])

    visit new_subsidiary_enroll_path(subsidiary.id)

    expect(current_path).to eq client_session_path
  end

  scenario 'and already enrolled to access new path' do
    client = create(:client)
    payment_option = create(:payment_option)
    subsidiary = Subsidiary.new(id: 1, name: 'Vila Maria',
                                address: 'Avenida Osvaldo Reis, 801', cep: '88306-773')
    plan = Plan.new(id: 1, name: 'Black', monthly_payment: 120.00, permanency: 12,
                    subsidiary: subsidiary)
    Enroll.create(subsidiary_id: subsidiary.id, plan_id: plan.id,
                  client_id: client.id, payment_option_id: payment_option.id)
    allow(Subsidiary).to receive(:all).and_return([subsidiary])
    allow(Plan).to receive(:all).and_return([plan])

    login_as client, scope: :client
    visit new_subsidiary_enroll_path(subsidiary.id)

    expect(page).to have_content('Você já está matriculado em uma unidade')
  end

  scenario 'enroll journey' do
    client = create(:client)
    payment_option = create(:payment_option)
    subsidiary = Subsidiary.new(id: 1, name: 'Vila Maria',
                                address: 'Avenida Osvaldo Reis, 801', cep: '88306-773')
    plan = Plan.new(id: 1, name: 'Black', monthly_payment: 120.00, permanency: 12,
                    subsidiary: subsidiary)
    # Enroll.create(subsidiary_id: subsidiary.id, plan_id: plan.id,
    #               client_id: client.id, payment_option_id: payment_option.id)
    allow(Subsidiary).to receive(:all).and_return([subsidiary])
    allow(Plan).to receive(:all).and_return([plan])

    login_as client, scope: :client
    visit root_path
    click_on subsidiary.name
    click_on 'Matricule-se agora'
    select plan.name, from: 'Plano'
    select payment_option.name, from: 'Forma de pagamento'
    fill_in 'Código promocional', with: "BFRIDAY001"
    click_on 'Próximo'

    expect(page).to have_content('Promoção:')
    # expect(page).to have_content('Você recebeu um desconto de: ')
    # expect(page).to have_content('Mensalidade: ')
    # expect(page).to have_content('por  meses')
  end
end
