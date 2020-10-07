require 'rails_helper'

feature 'Visitant view subisidiaries' do
  scenario 'see index of subsidiaries' do
    subsidiary_a = Subsidiary.new(id: 1, name: 'Vila Maria',
                                  address: 'Avenida Osvaldo Reis, 801',
                                  cep: '88306-773')
    subsidiary_b = Subsidiary.new(id: 2, name: 'Ipiranga',
                                  address: 'Rua da Concórdia, 201',
                                  cep: '57071-812')
    subsidiary_c = Subsidiary.new(id: 3, name: 'Santos',
                                  address: 'Rua das Hortências, 302',
                                  cep: '78150-384')

    allow(Subsidiary).to receive(:all)
                         .and_return([subsidiary_a, subsidiary_b, subsidiary_c])
    visit root_path

    expect(page).to have_content(subsidiary_a.name)
    expect(page).to have_content(subsidiary_a.address)
    expect(page).to have_content(subsidiary_a.cep)
    expect(page).to have_content(subsidiary_b.name)
    expect(page).to have_content(subsidiary_b.address)
    expect(page).to have_content(subsidiary_b.cep)
    expect(page).to have_content(subsidiary_c.name)
    expect(page).to have_content(subsidiary_c.address)
    expect(page).to have_content(subsidiary_c.cep)
  end

  scenario 'dont have any subsidiary' do
    allow(Subsidiary).to receive(:all).and_return([])

    visit root_path

    expect(page).to have_content('Nenhuma filial encontrada')
  end
end
