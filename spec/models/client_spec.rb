require 'rails_helper'

RSpec.describe Client, type: :model do
  context 'respond_to' do
    it { is_expected.to respond_to(:email) }
  end

  context 'validations' do
  end
end
