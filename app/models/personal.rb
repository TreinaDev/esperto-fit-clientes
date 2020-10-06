class Personal < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, :cref, :cpf, presence: true
  validate :validate_cpf
  validates :cref, format: { with: %r{\d{6}-[G|P]/\w{2}} }
  has_many :personal_subsidiaries

  def validate_cpf
    errors.add(:cpf) if cpf.present? && !CPF.valid?(cpf, strict: true)
  end
end
