require 'rails_helper'

feature 'User sign in' do

  xscenario 'from home page' do

    visit root_path
    expect(page).to have_link('Entrar')
    
  end
  
  scenario 'successfully' do

    visit new_client_registration_path
    fill_in 'CPF', with: '444.444.444-44'
    fill_in 'Email', with: 'test@email.com'
    fill_in 'Senha', with: '12345678'
    click_on 'Registrar'

    expect(Client.count).to eq(1)
    expect(page).to have_content('Sucessfully Login')
  end
  
  xscenario 'and sign out' do
    
    User.create!(name: 'Client Test', email: 'test@email.com', 
                 password: '12345678')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: 'test@email.com'
    fill_in 'Senha', with: '12345678'
    click_on 'Login'
    click_on 'Sair'
    
    
    expect(page).not_to have_content('Client Test')
    expect(page).to have_link('Entrar')
    expect(page).not_to have_link('Sair')
    
  end

  scenario 'cannot be blank' do
    
  end

  scenario 'must be unique' do
    
  end
end  