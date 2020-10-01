require 'rails_helper'

feature 'Personal Trainer register' do
  scenario 'successfully' do
   
    visit root_path
    click_on 'Registrar Personal Trainer'

    fill_in 'Nome', with: 'Alberto'
    fill_in 'email', with: 'alberto@gmail.com'
    fill_in  'cpf', with: '3399442568'
    fill_in 'cref', with: '123456-G'
    click_on 'Enviar'

    expect(current_path).to eq root_path
    expect(page).to have_content("Alberto, cadastrado com sucesso!")
  end
end
