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
  before_validation :clean_cpf
  has_many :personal_subsidiaries, dependent: :destroy

  private

  def validate_cpf
    errors.add(:cpf) if cpf.present? && !CPF.valid?(cpf, strict: true)
  end

  def clean_cpf
    self[:cpf] = CPF.new(cpf).stripped
  end
end
