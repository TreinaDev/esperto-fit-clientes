require 'rails_helper'

feature 'Personal view index appointments' do
  scenario 'not logged in personal do not see link to appointment' do
    visit root_path

    expect(page).not_to have_link('Minha Agenda')
  end

  scenario 'logged in personal see link to appointment' do
    personal = create(:personal); login_as(personal)
    visit root_path

    expect(page).to have_link('Minha Agenda')
  end
end
