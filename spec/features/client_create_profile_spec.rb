require 'rails_helper'

feature 'cliente create profile' do
  scenario 'and must has enroll' do
    client = create(:client)
    login_as client, scope: :client
    visit root_path

    expect(page).not_to have_link('Complete seu perfil')
    expect(page).not_to have_link('Ver perfil')
  end
  scenario 'sucessfully' do

    client = create(:client)
    payment_option = create(:payment_option)
    subsidiary = Subsidiary.new(id: 1, name: 'Vila Maria',
                                    address: 'Avenida Osvaldo Reis, 801', cep: '88306-773')
    plan = Plan.new(id: 1, name: 'Black', monthly_payment: 120.00, permanency: 12,
                          subsidiary: subsidiary)
    enroll = Enroll.create!(client_id:client.id, plan_id:plan.id, payment_option_id: payment_option.id,
                    subsidiary_id:subsidiary.id)

    login_as client, scope: :client
    visit root_path
    click_on 'Complete seu perfil'
    fill_in 'Nome', with: 'Jonas'
    fill_in 'Endereço', with: 'Rua Vila Velha, 101'
    click_on 'Salvar dados'

    expect(page).to have_content('Jonas')
    expect(page).to have_content('Rua Vila Velha, 101')
    expect(page).not_to have_content('Complete seu perfil')
    expect(page).to have_link('Voltar')
  end

  scenario 'and attributes cannot be blank' do
    client = create(:client)
    payment_option = create(:payment_option)
    subsidiary = Subsidiary.new(id: 1, name: 'Vila Maria',
                                    address: 'Avenida Osvaldo Reis, 801', cep: '88306-773')
    plan = Plan.new(id: 1, name: 'Black', monthly_payment: 120.00, permanency: 12,
                          subsidiary: subsidiary)
    enroll = Enroll.create!(client_id:client.id, plan_id:plan.id, payment_option_id: payment_option.id,
                    subsidiary_id:subsidiary.id)
                    
    root_path
    login_as client, scope: :client
    visit root_path
    click_on 'Complete seu perfil'
    click_on 'Salvar dados'

    expect(page).to have_content('não pode ficar em branco')
    expect(page).to have_content('não pode ficar em branco')
    expect(page).to have_content('não pode ficar em branco')
    expect(page).to have_content('não pode ficar em branco')
    expect(page).to have_link('Voltar')
  end
end


  