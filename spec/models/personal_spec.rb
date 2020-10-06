require 'rails_helper'

RSpec.describe Personal, type: :model do
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
end
