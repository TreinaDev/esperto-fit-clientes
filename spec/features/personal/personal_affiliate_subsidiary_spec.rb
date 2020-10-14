require 'rails_helper'

feature 'Personal Trainer bind subsidiaries' do
  scenario 'sucessly' do
    faraday_response = double('cpf_check', status: 200, body: 'false')
    allow(Faraday).to receive(:get).and_return(faraday_response)
    personal = create(:personal)
    allow(Subsidiary).to receive(:search)
      .and_return([Subsidiary.new(name: 'Vila Maria', address: 'Avenida Osvaldo Reis, 801',
                                  cep: '88306-773', id: 1)])

    login_as(personal, scope: :personal)

    visit root_path
    fill_in 'Busca de filiais', with: 'Vila Maria'
    click_on 'Buscar'
    click_on 'Vila Maria'
    click_on 'Adicionar Filial'

    expect(current_path).to eq subsidiary_path(1)
    expect(page).to have_content('Vila Maria')
    expect(page).to have_content('Avenida Osvaldo Reis, 801')
    expect(page).to have_content('88306-773')
    expect(page).to have_content('Filial adicionada com sucesso!')
    expect(page).to_not have_content('Super Esperto')
    expect(page).to_not have_content('Avenida Ipiranga, 150')
  end
end
