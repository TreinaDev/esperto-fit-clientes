require 'rails_helper'

feature 'Visitor searches subsidiary' do
  scenario 'successfully' do
    #Arrange
    allow(Subsidiary).to receive(:search).and_return([
      Subsidiary.new(name:'EspertoII', address:'Avenida Paulista, 150', neighborhood: 'Bela vista'),
      Subsidiary.new(name:'Super Esperto', address:'Avenida Ipiranga, 150', neighborhood: 'Centro')
    ])
    #Act
    visit root_path
    fill_in 'Busca de filiais', with: 'Bela vista'
    click_on 'Buscar'
    #Assert
    expect(current_path).to eq search_path
    expect(page).to have_content('EspertoII')
    expect(page).to have_content('Avenida Paulista, 150')
    expect(page).to have_content('Bela Vista')
    expect(page).to_not have_content('Super Esperto')
    expect(page).to_not have_content('Avenida Ipiranga, 150')
    expect(page).to_not have_content('Centro')
  end

  xscenario 'unsuccessfully' do
  end
end
