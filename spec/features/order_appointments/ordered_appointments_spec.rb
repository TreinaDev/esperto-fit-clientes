require 'rails_helper'

feature 'Ordered Appointments' do
  scenario 'Client view all their ordered appointments' do
    client = create(:client)
    login_as(client, scope: :client)
    appointments = create_list(:appointment, 2)
    other_appointment = create(:appointment, appointment_date: Time.zone.tomorrow)
    create(:order_appointment, client: client, appointment: appointments[0])
    create(:order_appointment, client: client, appointment: appointments[1])

    visit root_path
    click_link 'Treinos agendados'

    expect(page).to have_content(appointments[0].appointment_date)
    expect(page).to have_content(appointments[1].appointment_date)
    expect(page).not_to have_content(other_appointment.appointment_date)
  end
end
