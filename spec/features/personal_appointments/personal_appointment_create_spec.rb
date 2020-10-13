require 'rails_helper'

feature 'Personal Creates Appointment' do
  scenario 'personal must be logged in' do
    visit new_appointment_path

    expect(current_path).to eq(new_personal_session_path)
  end

  scenario 'page have link to new_appointment_path' do
    personal = create(:personal)
    login_as(personal)
    visit appointments_path

    expect(page).to have_link('Novo horário', href: new_appointment_path)
  end

  scenario 'successfully' do
    personal = create(:personal)
    login_as(personal)
    visit appointments_path
    click_on 'Novo horário'

    fill_in 'Data', with: Date.tomorrow
    fill_in 'Preço por hora', with: 50.00
    click_on 'Enviar'

    expect(page).to have_content('Agenda criada com sucesso')
    expect(page).to have_content(Date.tomorrow.strftime('%d/%m/%Y'))
    expect(page).to have_content('R$ 50,00')
  end

  scenario 'fail error messages' do
    personal = create(:personal)
    login_as(personal)
    visit appointments_path
    click_on 'Novo horário'

    fill_in 'Data', with: ''
    click_on 'Enviar'

    expect(page).to have_content('não pode ficar em branco')
  end
end
