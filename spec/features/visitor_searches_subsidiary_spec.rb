require 'rails_helper'

feature 'Visitor searches subsidiary' do
  scenario 'successfully' do
    allow(Subsidiary).to receive(:search)
      .and_return([Subsidiary.new(name: 'EspertoII', address: 'Avenida Paulista, 150',
                                  cep: '12345-678', id: 1)])

    visit root_path
    fill_in 'Busca de filiais', with: 'EspertoII'
    click_on 'Buscar'

    expect(current_path).to eq search_subsidiaries_path
    expect(page).to have_content('EspertoII')
    expect(page).to have_content('Avenida Paulista, 150')
    expect(page).to have_content('12345-678')
    expect(page).to_not have_content('Super Esperto')
    expect(page).to_not have_content('Avenida Ipiranga, 150')
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
                                  cep: '12345-678', id: 1)])

    visit root_path
    fill_in 'Busca de filiais', with: 'avenida paulista'
    click_on 'Buscar'

    expect(current_path).to eq search_subsidiaries_path
    expect(page).to have_content('EspertoII')
    expect(page).to have_content('Avenida Paulista, 150')
    expect(page).to have_content('12345-678')
    expect(page).to_not have_content('Super Esperto')
    expect(page).to_not have_content('Avenida Ipiranga, 150')
  end

  scenario 'search for partial name or neighborhood' do
    allow(Subsidiary).to receive(:search)
      .and_return([Subsidiary.new(name: 'EspertoII', address: 'Avenida Paulista, 150',
                                  cep: '12345-678', id: 1),
                   Subsidiary.new(name: 'Nome Novo', address: 'Endereço Esperto, 101',
                                  cep: '98765-432', id: 2)])

    visit root_path
    fill_in 'Busca de filiais', with: 'Esperto'
    click_on 'Buscar'

    expect(page).to have_content('EspertoII')
    expect(page).to have_content('Nome Novo')
    expect(page).to_not have_content('Diferentão')
  end

  scenario 'search by cep' do
    allow(Subsidiary).to receive(:search)
      .and_return([Subsidiary.new(name: 'EspertoII', address: 'Avenida Paulista, 150',
                                  cep: '12345-678', id: 1)])

    visit root_path
    fill_in 'Busca de filiais', with: '12345-678'
    click_on 'Buscar'

    expect(page).to have_content('EspertoII')
    expect(page).to_not have_content('Nome Novo')
  end

  scenario 'search wrong cep' do
    allow(Subsidiary).to receive(:search)
      .and_return([])

    visit root_path
    fill_in 'Busca de filiais', with: '12345'
    click_on 'Buscar'

    expect(page).to have_content('Nenhuma filial encontrada')
    expect(page).to_not have_content('EspertoII')
  end

  scenario 'search by cep without -' do
    allow(Subsidiary).to receive(:search)
      .and_return([Subsidiary.new(name: 'EspertoII', address: 'Avenida Paulista, 150',
                                  cep: '12345-678', id: 1)])

    visit root_path
    fill_in 'Busca de filiais', with: '12345678'
    click_on 'Buscar'

    expect(page).to have_content('EspertoII')
    expect(page).to_not have_content('Nome Novo')
  end
end
