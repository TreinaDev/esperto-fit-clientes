require 'rails_helper'

feature 'Personal Trainer register' do
  scenario 'successfully' do
    visit root_path
    click_on 'Registrar Personal Trainer'
    fill_in 'Nome', with: 'Alberto'
    fill_in 'Email', with: 'alberto@gmail.com'
    fill_in  'CPF', with: '3399442568'
    fill_in 'CREF', with: '123456-G'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmar senha', with: '123456'
    click_on 'Enviar'

    expect(current_path).to eq root_path
    expect(page).to have_content("Alberto")
    expect(page).to have_content("com sucesso")
  end

  scenario 'did not fill all the fields' do
    visit root_path
    click_on 'Registrar Personal Trainer'
    click_on 'Enviar'

    expect(current_path).to_not eq root_path
    expect(page).to have_content('não pode ficar em branco', count: 5)
  end
end
