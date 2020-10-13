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
  end

  it 'CPF and CREF must be valid' do
    personal = Personal.create(cpf: '12345', cref: '67890')

    expect(personal.errors[:cref]).to include('não é válido')
    expect(personal.errors[:cpf]).to include('não é válido')
  end

  it 'CPF and CREF must be unique' do
    personal = create(:personal)
    personal2 = build(:personal, cpf: personal.cpf, cref: personal.cref)
    personal2.valid?

    expect(personal2.errors[:cpf]).to include('já está em uso')
    expect(personal2.errors[:cref]).to include('já está em uso')
  end
end
