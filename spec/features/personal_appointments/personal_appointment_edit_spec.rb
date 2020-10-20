require 'rails_helper'

feature 'Personal edit Appointment' do
  scenario 'only logged in personal' do
    appointment = create(:appointment)
    visit edit_appointment_path(appointment)

    expect(current_path).to eq(new_personal_session_path)
  end

  scenario 'successfully' do
    personal = create(:personal)
    login_as(personal)
    appointment = create(:appointment, personal: personal)
    visit appointment_path(appointment)
    click_link 'Editar'

    fill_in 'Data', with: Date.tomorrow
    click_on 'Enviar'

    expect(page).to have_content('Editado com sucesso')
  end

  scenario 'edit only their own' do
    personal = create(:personal, email: 'not_owner@email.com')
    login_as(personal)
    appointment = create(:appointment)
    visit appointment_path(appointment)

    expect(page).not_to have_link('Editar', exact: true)
  end
end
