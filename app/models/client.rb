class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :cpf, presence: true
  validates :cpf, uniqueness: true
  validate :cpf_validation
  # validate :cpf_ban? is true

  private

  def cpf_validation
    return if CPF.valid?(cpf)

    errors.add(:cpf, :cpf_invalid)
  end

  def cpf_ban?
    #  GET 'url_tal_tal_tal'
    #  if response
    #    self.status = 'banned'
    #    true
    #  else
    #    false
    #  end
  end
end
