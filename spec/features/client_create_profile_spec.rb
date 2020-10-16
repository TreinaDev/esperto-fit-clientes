require 'rails_helper'

feature 'cliente create profile' do
  before do
    allow(Subsidiary).to receive(:all)
      .and_return([Subsidiary.new(id: 1, name: 'Vila Maria', address: 'Avenida Osvaldo Reis, 801',
                                  cnpj: '11189348000195', token: 'CK4XEB'),
                   Subsidiary.new(id: 1, name: 'Super Esperto', address: 'Avenida Ipiranga, 150',
                                  cnpj: '11189348000195', token: 'CK4XEB')])
  end

  scenario 'and must has enroll' do
    faraday_response = double('cpf_check', status: 200, body: 'false')
    allow(Faraday).to receive(:get).and_return(faraday_response)
    client = create(:client)
    login_as client, scope: :client
    visit root_path

    expect(page).not_to have_link('Complete seu perfil')
    expect(page).not_to have_link('Ver perfil')
  end

  scenario 'from new_profile_path' do
    faraday_response = double('cpf_check', status: 200, body: 'false')
    allow(Faraday).to receive(:get).and_return(faraday_response)
    client = create(:client)
    login_as client, scope: :client
    visit new_profile_path

    expect(current_path).to eq root_path
  end

  scenario 'sucessfully' do
    faraday_response = double('cpf_check', status: 200, body: 'false')
    allow(Faraday).to receive(:get).and_return(faraday_response)
    client = create(:client)
    payment_option = create(:payment_option)
    subsidiary = Subsidiary.new(id: 1, name: 'Vila Maria', address: 'Avenida Osvaldo Reis, 801',
                                cnpj: '11189348000195', token: 'CK4XEB')
    plan = Plan.new(id: 1, name: 'Black', monthly_payment: 120.00, permanency: 12,
                    subsidiary: subsidiary)
    Enroll.create!(client: client, plan_id: plan.id,
                   payment_option: payment_option,
                   subsidiary_id: subsidiary.id)
    allow(Subsidiary).to receive(:all).and_return([subsidiary])
    allow(subsidiary).to receive(:plans).and_return([plan])

    login_as client, scope: :client
    visit root_path
    click_on 'Complete seu perfil'
    fill_in 'Nome', with: 'Jonas'
    fill_in 'Endereço', with: 'Rua Vila Velha, 101'
    fill_in 'Telefone', with: '1199999999'

    click_on 'Salvar dados'

    expect(page).to have_content('Jonas')
    expect(page).to have_content('Rua Vila Velha, 101')
    expect(page).to have_content('Perfil criado com sucesso')
    expect(page).not_to have_content('Complete seu perfil')
    expect(page).to have_link('Voltar', href: root_path)
  end

  scenario 'and attributes cannot be blank' do
    faraday_response = double('cpf_check', status: 200, body: 'false')
    allow(Faraday).to receive(:get).and_return(faraday_response)
    client = create(:client)
    payment_option = create(:payment_option)
    subsidiary = Subsidiary.new(id: 1, name: 'Vila Maria', address: 'Avenida Osvaldo Reis, 801',
                                cnpj: '11189348000195', token: 'CK4XEB')
    plan = Plan.new(id: 1, name: 'Black', monthly_payment: 120.00, permanency: 12,
                    subsidiary: subsidiary)
    Enroll.create!(client_id: client.id, plan_id: plan.id,
                   payment_option_id: payment_option.id,
                   subsidiary_id: subsidiary.id)

    root_path
    login_as client, scope: :client
    visit root_path
    click_on 'Complete seu perfil'
    click_on 'Salvar dados'

    expect(page).to have_content('não pode ficar em branco', count: 2)
    expect(page).to have_link('Voltar', href: root_path)
  end
end
