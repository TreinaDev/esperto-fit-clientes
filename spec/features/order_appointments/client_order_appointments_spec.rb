require 'rails_helper'

feature 'Order Appointments' do
  scenario 'Client view available appointments' do
    client = create(:client)
    login_as(client, scope: :client)
    appointments = create_list(:appointment, 2)

    visit root_path
    click_link 'Personais disponíveis'

    expect(page).to have_content(appointments[0].appointment_date)
    expect(page).to have_content(appointments[1].appointment_date)
    expect(page).to have_content(appointments[1].appointment_time)
    expect(page).to have_content(appointments[1].appointment_time)
  end

  scenario 'only available appointments' do
    client = create(:client)
    login_as(client, scope: :client)
    appointments = create_list(:appointment, 2)
    not_available = create(:appointment, status: :ordered, appointment_date: Time.zone.tomorrow)

    visit root_path
    click_link 'Personais disponíveis'

    expect(page).to have_content(appointments[0].appointment_date)
    expect(page).to have_content(appointments[1].appointment_date)
    expect(page).not_to have_content(not_available.appointment_date)
  end

  scenario 'view details' do
    client = create(:client)
    login_as(client, scope: :client)
    appointment = create(:appointment)

    visit root_path
    click_link 'Personais disponíveis'
    click_on 'Mais informações'

    expect(current_path).to eq(appointment_path(appointment))
    expect(page).to have_link('Agendar este horário')
  end

  scenario 'successfully order appointment' do
    client = create(:client)
    login_as(client, scope: :client)
    appointment = create(:appointment)

    visit root_path
    click_link 'Personais disponíveis'
    click_on 'Mais informações'
    click_link 'Agendar este horário'

    appointment.reload

    expect(page).to have_content('Agendamento realizado com sucesso')
    expect(appointment.status).to eq('ordered')
  end
end
