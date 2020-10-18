require 'rails_helper'

feature 'Personal view index appointments' do
  before do
    allow(Subsidiary).to receive(:all)
      .and_return([Subsidiary.new(id: 1, name: 'Vila Maria', address: 'Avenida Osvaldo Reis, 801',
                                  cnpj: '11189348000195', token: 'CK4XEB'),
                   Subsidiary.new(id: 1, name: 'Super Esperto', address: 'Avenida Ipiranga, 150',
                                  cnpj: '11189348000195', token: 'CK4XEB')])
  end

  scenario 'not logged in personal do not see link to appointment' do
    visit root_path

    expect(page).not_to have_link('Minha Agenda')
  end

  scenario 'logged in personal see link to appointment' do
    personal = create(:personal)
    login_as(personal)
    visit root_path

    expect(page).to have_link('Minha Agenda', href: appointments_path)
  end

  scenario 'personal appointments empty' do
    personal = create(:personal)
    login_as(personal)
    visit root_path
    click_on 'Minha Agenda'

    within('#appointments_list') do
      expect(page).to have_content('Nenhuma atividade agendada')
    end
  end

  scenario 'personal appointments not empty' do
    personal = create(:personal)
    login_as(personal)
    create(:appointment, personal: personal)
    visit root_path
    click_on 'Minha Agenda'

    expect(page).not_to have_content('Nenhuma atividade agendada')
  end

  scenario 'personal see list of appointment' do
    personal = create(:personal, cpf: '478.145.318-02')
    login_as(personal)
    appointment = create(:appointment, personal: personal)
    visit root_path
    click_on 'Minha Agenda'

    expect(page).to have_content(appointment.appointment_date.strftime('%d/%m/%Y'))
  end

  scenario 'personal see list of only their appointments' do
    personal = create(:personal)
    login_as(personal)
    appointment = create(:appointment, personal: personal)
    personal2 = create(:personal)
    create(:appointment, personal: personal2, appointment_date: Date.tomorrow)
    visit root_path
    click_on 'Minha Agenda'

    expect(page).to have_content(appointment.appointment_date.strftime('%d/%m/%Y'))
  end
end
