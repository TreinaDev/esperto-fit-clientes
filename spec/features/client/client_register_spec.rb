require 'rails_helper'

feature 'User sign in' do
  scenario 'successfully' do
    visit new_client_registration_path
    fill_in 'CPF', with: '444.444.444-44'
    fill_in 'Email', with: 'test@email.com'
    fill_in 'Senha', with: '12345678'
    click_on 'Registrar'

    expect(Client.count).to eq(1)
    expect(page).to have_content('Sucessfully Login')
  end
end
