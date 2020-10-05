class Client < ApplicationRecord
  has_many :enrolls, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :cpf, presence: true
  validates :cpf, uniqueness: true
  validate :cpf_validation

  # def enrolled?
  #  enroll.exists?
  # end

  private

  def cpf_validation
    return if CPF.valid?(cpf)

    errors.add(:cpf, :cpf_invalid)
  end
end
