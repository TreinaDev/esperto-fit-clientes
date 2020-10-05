class Personal < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
       
  validates :name, :cref, :cpf , presence: true
  validate :validate_cpf

  def validate_cpf
    if cpf.present? and not CPF.valid?(cpf, strict: true)
      errors.add(:cpf, 'inválido')
    end
  end
end
