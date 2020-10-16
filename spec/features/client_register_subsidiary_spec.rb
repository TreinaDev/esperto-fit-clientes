require 'rails_helper'

feature 'client enroll a subsidiary' do
  scenario 'and view details summary' do
    faraday_response = double('cpf_check', status: 200, body: 'false')
    allow(Faraday).to receive(:get).with('http://subsidiaries/api/v1/banned_user/47814531802')
                                   .and_return(faraday_response)
    client = create(:client, cpf: '478.145.318-02')
    payment_option = create(:payment_option)
    subsidiary = Subsidiary.new(id: 1, name: 'Vila Maria', address: 'Avenida Osvaldo Reis, 801',
                                cnpj: '11189348000195', token: 'CK4XEB')
    plan = Plan.new(id: 1, name: 'Black', monthly_payment: 120.00, permanency: 12,
                    subsidiary: subsidiary)
    allow(Subsidiary).to receive(:all).and_return([subsidiary])
    allow(subsidiary).to receive(:plans).and_return([plan])

    login_as client, scope: :client
    visit root_path
    click_on subsidiary.name
    click_on 'Matricule-se agora'
    select 'Black - R$ 120,00', from: 'Plano'
    select payment_option.name, from: 'Forma de pagamento'
    click_on 'Próximo'

    expect(page).to have_content(client.cpf)
    expect(page).to have_content(client.email)
    expect(page).to have_content(plan.name)
    expect(page).to have_content('Boleto')
    expect(page).to have_content("#{plan.permanency} meses")
    expect(page).to have_content('R$ 120,00')
    expect(page).to have_link('Confirmar')
    expect(page).to have_link('Voltar')
  end

  scenario 'sucessfully' do
    faraday_response = double('cpf_check', status: 200, body: 'false')
    allow(Faraday).to receive(:get).with('http://subsidiaries/api/v1/banned_user/47814531802')
                                   .and_return(faraday_response)
    client = create(:client, cpf: '478.145.318-02')
    payment_option = create(:payment_option)
    subsidiary = Subsidiary.new(id: 1, name: 'Vila Maria', address: 'Avenida Osvaldo Reis, 801',
                                cnpj: '11189348000195', token: 'CK4XEB')
    plan = Plan.new(id: 1, name: 'Black', monthly_payment: 120.00, permanency: 12,
                    subsidiary: subsidiary)
    allow(Subsidiary).to receive(:all).and_return([subsidiary])
    allow(subsidiary).to receive(:plans).and_return([plan])

    login_as client, scope: :client
    visit root_path
    click_on subsidiary.name
    click_on 'Matricule-se agora'
    select 'Black - R$ 120,00', from: 'Plano'
    select payment_option.name, from: 'Forma de pagamento'
    click_on 'Próximo'
    click_on 'Confirmar'

    expect(page).to have_content('Matricula realizada com sucesso')
  end

  scenario 'not must fill in blank' do
    faraday_response = double('cpf_check', status: 200, body: 'false')
    allow(Faraday).to receive(:get).with('http://subsidiaries/api/v1/banned_user/47814531802')
                                   .and_return(faraday_response)
    client = create(:client, cpf: '478.145.318-02')
    subsidiary = Subsidiary.new(id: 1, name: 'Vila Maria', address: 'Avenida Osvaldo Reis, 801',
                                cnpj: '11189348000195', token: 'CK4XEB')
    plan = Plan.new(id: 1, name: 'Black', monthly_payment: 120.00, permanency: 12,
                    subsidiary: subsidiary)
    allow(Subsidiary).to receive(:all).and_return([subsidiary])
    allow(subsidiary).to receive(:plans).and_return([plan])

    login_as client, scope: :client
    visit root_path
    click_on subsidiary.name
    click_on 'Matricule-se agora'
    click_on 'Próximo'

    expect(page).to have_content('não pode ficar em branco', count: 1)
    expect(page).to have_content('é obrigatório(a)', count: 1)
  end

  scenario 'and return to enroll form' do
    faraday_response = double('cpf_check', status: 200, body: 'false')
    allow(Faraday).to receive(:get).with('http://subsidiaries/api/v1/banned_user/47814531802')
                                   .and_return(faraday_response)
    client = create(:client, cpf: '478.145.318-02')
    payment_option = create(:payment_option)
    subsidiary = Subsidiary.new(id: 1, name: 'Vila Maria', address: 'Avenida Osvaldo Reis, 801',
                                cnpj: '11189348000195', token: 'CK4XEB')
    plan = Plan.new(id: 1, name: 'Black', monthly_payment: 120.00, permanency: 12,
                    subsidiary: subsidiary)
    allow(Subsidiary).to receive(:all).and_return([subsidiary])
    allow(subsidiary).to receive(:plans).and_return([plan])

    login_as client, scope: :client
    visit root_path
    click_on subsidiary.name
    click_on 'Matricule-se agora'
    select 'Black - R$ 120,00', from: 'Plano'
    select payment_option.name, from: 'Forma de pagamento'
    click_on 'Próximo'
    click_on 'Voltar'

    expect(current_path).to eq new_subsidiary_enroll_path(subsidiary.id)
  end
end
