class Client < ApplicationRecord
  has_one :enroll, -> { order(created_at: :desc) }, inverse_of: :client
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :cpf, :status, presence: true
  validates :cpf, uniqueness: true
  validate :cpf_validation
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

  def partner?
    VerifyPartnershipService.new(self).call
  end

  def domain
    email.split('@')[1]
  end

  def already_enrolled?
    enroll.present?
  end

  def active_for_authentication?
    super && cpf_get_status
  end

  def inactive_message
    'Você foi banido'
  end

  private

  def cpf_validation
    return if CPF.valid?(cpf)

    errors.add(:cpf, :cpf_invalid)
  end
end
