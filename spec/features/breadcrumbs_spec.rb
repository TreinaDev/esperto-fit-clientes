require 'rails_helper'

feature 'Breadcrumbs' do
  context 'subsidiaries and enroll' do
    scenario 'show' do
      visit root_path
      click_on 'Vila Maria'

      expect(page).to have_link('Home', href: root_path)
      expect(page).to have_content('Home Vila Maria')
      expect(page).to_not have_content('Home Matrícula')
    end

    scenario 'search' do
      visit root_path
      click_on 'Buscar'

      expect(page).to have_link('Home', href: root_path)
      expect(page).to have_content('Home Busca')
      expect(page).to_not have_content('Home Vila Maria')
    end

    scenario 'enroll' do
      client = create(:client)

      login_as(client, scope: :client)
      visit root_path
      click_on 'Vila Maria'
      click_on 'Matricule-se'

      expect(page).to have_link('Home', href: root_path)
      expect(page).to have_link('Vila Maria')
      expect(page).to have_content('Home Vila Maria Matrícula')
      expect(page).to_not have_content('Home Busca')
    end
  end
end
