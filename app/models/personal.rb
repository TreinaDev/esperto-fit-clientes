class Personal < ApplicationRecord
  has_many :appointments, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, :cref, :cpf, presence: true
  validates :cref, :cpf, uniqueness: true
  validate :validate_cpf
  validates :cref, format: { with: %r{\d{6}-[G|P]/\w{2}} }
  has_many :personal_subsidiaries, dependent: :destroy

  def validate_cpf
    errors.add(:cpf) if cpf.present? && !CPF.valid?(cpf, strict: true)
  end
end
