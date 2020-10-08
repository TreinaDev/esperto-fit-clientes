class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :cpf, presence: true
  validates :cpf, uniqueness: true
  validate :cpf_validation
  # validate :status.active?,  acceptance: true
  # enum status: { active: 0, banned: 50 }

  def partner?
    VerifyPartnershipService.new(self).call
  end

  def domain
    email.split('@')[1]
  end

  def cpf_banned?
    # Verificar no active_for_authentication? (https://github.com/heartcombo/devise/blob/master/lib/devise/models/authenticatable.rb)
    #  GET 'url_tal_tal_tal'
    #  if response
    #    self.status = 'banned'
    #    true
    #  else
    #    false
    #  end
  end

  private

  def cpf_validation
    return if CPF.valid?(cpf)

    errors.add(:cpf, :cpf_invalid)
  end
end
