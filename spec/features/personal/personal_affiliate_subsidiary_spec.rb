require 'rails_helper'

feature 'Personal Trainer bind subsidiaries' do
  before do
    allow(Subsidiary).to receive(:all)
      .and_return([Subsidiary.new(id: 1, name: 'Vila Maria', address: 'Avenida Osvaldo Reis, 801',
                                  cnpj: '11189348000195', token: 'CK4XEB'),
                   Subsidiary.new(id: 1, name: 'Super Esperto', address: 'Avenida Ipiranga, 150',
                                  cnpj: '11189348000195', token: 'CK4XEB')])
  end

  scenario 'sucessly' do
    faraday_response = double('cpf_check', status: 404)
    allow(Faraday).to receive(:get).and_return(faraday_response)
    personal = create(:personal)
    login_as(personal, scope: :personal)

    visit root_path
    fill_in 'Busca de filiais', with: 'Vila Maria'
    click_on 'Buscar'
    click_on 'Vila Maria'
    click_on 'Adicionar Filial'

    expect(current_path).to eq subsidiary_path(1)
    expect(page).to have_content('Vila Maria')
    expect(page).to have_content('Avenida Osvaldo Reis, 801')
    expect(page).to have_content('Filial adicionada com sucesso!')
    expect(page).to_not have_content('Super Esperto')
    expect(page).to_not have_content('Avenida Ipiranga, 150')
  end
end
