require 'rails_helper'

feature 'client edit profile' do
  scenario 'sucessfully' do
    faraday_response = double('cpf_check', status: 200, body: 'false')
    allow(Faraday).to receive(:get).and_return(faraday_response)
    client = create(:client)
    payment_option = create(:payment_option)
    subsidiary = Subsidiary.new(id: 1, name: 'Vila Maria',
                                address: 'Avenida Osvaldo Reis, 801', cep: '88306-773')
    plan = Plan.new(id: 1, name: 'Black', monthly_payment: 120.00, permanency: 12,
                    subsidiary: subsidiary)
    enroll = Enroll.create!(client: client, plan_id: plan.id,
                            payment_option: payment_option,
                            subsidiary_id: subsidiary.id)
    profile = create(:profile, enroll: enroll)
    allow(Subsidiary).to receive(:all).and_return([subsidiary])
    allow(subsidiary).to receive(:plans).and_return([plan])

    login_as client, scope: :client
    visit root_path
    click_on 'Meu perfil'
    click_on 'Editar perfil'
    fill_in 'Nome', with: profile.name
    fill_in 'Endereço', with: profile.address
    click_on 'Salvar dados'

    expect(page).to have_content(profile.name)
    expect(page).to have_content(profile.address)
    expect(page).to have_link('Voltar', href: root_path)
  end

  scenario 'and attributes cannot be blank' do
    faraday_response = double('cpf_check', status: 200, body: 'false')
    allow(Faraday).to receive(:get).and_return(faraday_response)
    client = create(:client)
    payment_option = create(:payment_option)
    subsidiary = Subsidiary.new(id: 1, name: 'Vila Maria',
                                address: 'Avenida Osvaldo Reis, 801', cep: '88306-773')
    plan = Plan.new(id: 1, name: 'Black', monthly_payment: 120.00, permanency: 12,
                    subsidiary: subsidiary)
    enroll = Enroll.create!(client: client, plan_id: plan.id,
                            payment_option: payment_option,
                            subsidiary_id: subsidiary.id)
    profile = create(:profile, enroll: enroll)
    allow(Subsidiary).to receive(:all).and_return([subsidiary])
    allow(subsidiary).to receive(:plans).and_return([plan])

    login_as client, scope: :client
    visit root_path
    click_on 'Meu perfil'
    click_on 'Editar perfil'
    fill_in 'Nome', with: ''
    fill_in 'Endereço', with: ''
    click_on 'Salvar dados'

    expect(page).to have_content('não pode ficar em branco', count: 2)
    expect(page).to have_link('Voltar', href: profile_path(profile))
  end
end
