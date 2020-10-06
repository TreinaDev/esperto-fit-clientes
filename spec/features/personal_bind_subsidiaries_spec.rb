require 'rails_helper'

feature 'Personal Trainer bind subsidiaries' do 
  scenario 'sucessly' do 
    personal = create(:personal)
    allow(Subsidiary).to receive(:search)
      .and_return([Subsidiary.new(name: 'EspertoII', address: 'Avenida Paulista, 150',
                                  cep: '12345-678', id: 1)])

    login_as(personal, scope: :personal) 

    visit root_path
    fill_in 'Busca de filiais', with: 'EspertoII'
    click_on 'Buscar'   
    click_on 'EspertoII'
    click_on 'Adicionar Filial'

    expect(current_path).to eq subsidiary_path
    expect(page).to have_content('EspertoII')
    expect(page).to have_content('Avenida Paulista, 150')
    expect(page).to have_content('12345-678')
    expect(page).to have_content('Filial adicionada com sucesso!')
    expect(page).to_not have_content('Super Esperto')
    expect(page).to_not have_content('Avenida Ipiranga, 150')
  end
end