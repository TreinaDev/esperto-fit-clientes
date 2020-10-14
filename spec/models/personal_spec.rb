require 'rails_helper'

RSpec.describe Personal, type: :model do
  context 'associations' do
    it { is_expected.to have_many(:appointments).dependent(:destroy) }
  end

  it 'Name, CREF, CPF, Email and Password cannot be blank' do
    personal = Personal.create

    expect(personal.errors[:name]).to include('não pode ficar em branco')
    expect(personal.errors[:cref]).to include('não pode ficar em branco')
    expect(personal.errors[:cpf]).to include('não pode ficar em branco')
    expect(personal.errors[:email]).to include('não pode ficar em branco')
    expect(personal.errors[:password]).to include('não pode ficar em branco')
    expect(personal.errors[:status]).to include('não pode ficar em branco')
  end

  it 'CPF and CREF must be valid' do
    personal = Personal.create(cpf: '12345', cref: '67890')

    expect(personal.errors[:cref]).to include('não é válido')
    expect(personal.errors[:cpf]).to include('não é válido')
  end

  it 'CPF and CREF must be unique' do
    faraday_response = double('cpf_check', status: 200, body: 'false')
    allow(Faraday).to receive(:get).with('http://subsidiaries/api/v1/banned_user/47814531802')
                                   .and_return(faraday_response)
    personal = create(:personal, cpf: '478.145.318-02')
    personal2 = build(:personal, cpf: personal.cpf, cref: personal.cref)
    personal2.valid?

    expect(personal2.errors[:cpf]).to include('já está em uso')
    expect(personal2.errors[:cref]).to include('já está em uso')
  end

  context '#cpf_get_status' do
    it 'response is true from API' do
      personal = build(:personal, status: nil)

      faraday_response = double('cpf_ban', status: 200, body: 'true')

      allow(Faraday).to receive(:get).with("http://subsidiaries/api/v1/banned_user/#{CPF.new(personal.cpf).stripped}")
                                     .and_return(faraday_response)

      personal.cpf_get_status

      expect(personal.status).to eq 'banned'
    end

    it 'response is false from API' do
      personal = build(:personal, status: nil)
      faraday_response = double('cpf_ban', status: 200, body: 'false')

      allow(Faraday).to receive(:get).with("http://subsidiaries/api/v1/banned_user/#{CPF.new(personal.cpf).stripped}")
                                     .and_return(faraday_response)

      personal.cpf_get_status

      expect(personal.status).to eq 'active'
    end

    it 'error on API' do
      personal = build(:personal, status: nil)

      faraday_response = double('cpf_ban', status: 500)

      allow(Faraday).to receive(:get).with("http://subsidiaries/api/v1/banned_user/#{CPF.new(personal.cpf).stripped}")
                                     .and_return(faraday_response)

      personal.cpf_get_status

      expect(personal.status).to eq nil
      expect(personal.valid?).to eq false
    end
  end
end
