require 'rails_helper'

feature 'Personal cancel order appointment' do
  scenario 'need to be owner' do
    create(:personal)
    appointment = create(:appointment)
    create(:order_appointment, appointment: appointment)

    visit appointment_path(appointment)

    expect(page).not_to have_link('Cancelar agendamento')
  end

  scenario 'have link' do
    personal = create(:personal)
    login_as(personal, scope: :personal)
    appointment = create(:appointment, personal: personal, status: 'ordered')
    create(:order_appointment, appointment: appointment)

    visit root_path
    click_link 'Minha Agenda'
    click_link 'Detalhes'

    expect(page).to have_link('Cancelar agendamento', href: cancel_appointment_path(appointment))
  end

  scenario 'successfully' do
    personal = create(:personal)
    login_as(personal, scope: :personal)
    appointment = create(:appointment, personal: personal, status: 'ordered')
    create(:order_appointment, appointment: appointment)

    visit root_path
    click_link 'Minha Agenda'
    click_link 'Detalhes'
    click_link 'Cancelar agendamento'

    appointment.reload
    expect(page).to have_content('Agendamento cancelado')
    expect(appointment.status).to eq('canceled')
  end
end
