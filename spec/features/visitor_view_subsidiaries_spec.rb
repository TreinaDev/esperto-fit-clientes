require 'rails_helper'

feature 'Visitant view subisidiaries' do
  scenario 'see index of subsidiaries' do
    subsidiary_a = Subsidiary.new(id: 1, name: 'Vila Maria', address: 'Avenida Osvaldo Reis, 801',
                                  cnpj: '11189348000195', token: 'CK4XEB')
    subsidiary_b = Subsidiary.new(id: 1, name: 'Ipiranga', address: 'Rua da concordia, 802',
                                  cnpj: '11189348000195', token: 'CK4XEB')
    subsidiary_c = Subsidiary.new(id: 1, name: 'Santos', address: 'Rua das Hortencia, 803',
                                  cnpj: '11189348000195', token: 'CK4XEB')

    allow(Subsidiary).to receive(:all).and_return([subsidiary_a, subsidiary_b, subsidiary_c])
    visit root_path

    expect(page).to have_content(subsidiary_a.name)
    expect(page).to have_content(subsidiary_a.address)
    expect(page).to have_content(subsidiary_b.name)
    expect(page).to have_content(subsidiary_b.address)
    expect(page).to have_content(subsidiary_c.name)
    expect(page).to have_content(subsidiary_c.address)
  end

  scenario 'dont have any subsidiary' do
    allow(Subsidiary).to receive(:all).and_return([])

    visit root_path

    expect(page).to have_content('Nenhuma filial encontrada')
  end
end
