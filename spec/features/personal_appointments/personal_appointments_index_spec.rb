require 'rails_helper'

feature 'Personal view index appointments' do
  scenario 'not logged in personal do not see link to appointment' do
    visit root_path

    expect(page).not_to have_link('Minha Agenda')
  end

  scenario 'logged in personal see link to appointment' do
    personal = create(:personal); login_as(personal)
    visit root_path

    expect(page).to have_link('Minha Agenda', href: personal_appointments_path(personal))
  end

  scenario 'personal appointments empty' do
    personal = create(:personal); login_as(personal)
    visit root_path
    click_on 'Minha Agenda'
 
    within('#appointments_list') do
      expect(page).to have_content('Nenhuma atividade agendada') 
    end
  end

  scenario 'personal create appointment' do
    personal = create(:personal, email: 'personal@mail.com'); login_as(personal)
    appointment = create(:appointment)
    visit root_path
    click_on 'Minha Agenda'
    
    expect(page).to have_content(appointment.appointment_date)
    #expect(page).to have_content(appointment.appointment_time)
  end
end
