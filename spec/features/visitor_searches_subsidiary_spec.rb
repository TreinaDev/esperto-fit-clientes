require 'rails_helper'

feature 'Visitor searches subsidiary' do
  scenario 'successfully' do
    allow(Subsidiary).to receive(:search)
      .and_return([Subsidiary.new(name: 'EspertoII', address: 'Avenida Paulista, 150',
                                  neighborhood: 'Bela Vista')])

    visit root_path
    fill_in 'Busca de filiais', with: 'Bela vista'
    click_on 'Buscar'

    expect(current_path).to eq search_subsidiaries_path
    expect(page).to have_content('EspertoII')
    expect(page).to have_content('Avenida Paulista, 150')
    expect(page).to have_content('Bela Vista')
    expect(page).to_not have_content('Super Esperto')
    expect(page).to_not have_content('Avenida Ipiranga, 150')
    expect(page).to_not have_content('Centro')
  end

  scenario 'unsuccessfully' do
    allow(Subsidiary).to receive(:search).and_return([])

    visit root_path
    fill_in 'Busca de filiais', with: 'Butantã'
    click_on 'Buscar'

    expect(page).to_not have_content('EspertoII')
    expect(page).to_not have_content('Avenida Paulista')
    expect(page).to have_content('Nenhuma filial encontrada')
  end

  scenario 'find search case sensitive' do
    allow(Subsidiary).to receive(:search)
      .and_return([Subsidiary.new(name: 'EspertoII', address: 'Avenida Paulista, 150',
                                  neighborhood: 'Bela Vista')])

    visit root_path
    fill_in 'Busca de filiais', with: 'bela vista'
    click_on 'Buscar'

    expect(current_path).to eq search_subsidiaries_path
    expect(page).to have_content('EspertoII')
    expect(page).to have_content('Avenida Paulista, 150')
    expect(page).to have_content('Bela Vista')
    expect(page).to_not have_content('Super Esperto')
    expect(page).to_not have_content('Avenida Ipiranga, 150')
    expect(page).to_not have_content('Centro')
  end
end
