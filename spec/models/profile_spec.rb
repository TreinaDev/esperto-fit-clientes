require 'rails_helper'

RSpec.describe Profile, type: :model do
  context 'validation' do
    it 'attributes cannot be blank' do
      profile = Profile.new

      profile.valid?

      expect(profile.errors[:name]).to include('não pode ficar em branco')
      expect(profile.errors[:address]).to include('não pode ficar em branco')
      expect(profile.errors[:enroll]).to include('é obrigatório(a)')
    end
  end
end
