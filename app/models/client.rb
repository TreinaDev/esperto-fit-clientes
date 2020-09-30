class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :cpf, presence: true
  validates :cpf, uniqueness: true
  validate :cpf_validation

  private

  def cpf_validation
    return if CPF.valid?(cpf)

    errors.add(:cpf, 'CPF precisa ser válido')
  end
end
