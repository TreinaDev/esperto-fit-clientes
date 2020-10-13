class Personal < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, :cref, :cpf, :status, presence: true
  validate :validate_cpf
  validates :cref, format: { with: %r{\d{6}-[G|P]/\w{2}} }
  before_validation :cpf_get_status

  enum status: { active: 0, banned: 900 }

  def cpf_get_status
    return unless CPF.valid?(cpf)

    response = Faraday.get "http://subsidiaries/api/v1/banned_user/#{CPF.new(cpf).stripped}"

    return unless response.status == 200

    case response.body
    when 'true'
      self.status = 'banned'
      false
    when 'false'
      self.status = 'active'
    end
  end

  def active_for_authentication?
    super && cpf_get_status
  end

  def inactive_message
    'Você foi banido'
  end

  private

  def validate_cpf
    errors.add(:cpf) if cpf.present? && !CPF.valid?(cpf, strict: true)
  end
end
