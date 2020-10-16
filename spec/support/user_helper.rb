RSpec.configure do |configure|
  configure.before(:each) do
    allow_any_instance_of(Client).to receive(:cpf_banned?).and_return(false)
    allow_any_instance_of(Personal).to receive(:cpf_banned?).and_return(false)
  end
end
