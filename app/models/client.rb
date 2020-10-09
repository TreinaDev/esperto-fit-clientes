class Client < ApplicationRecord
  has_one :enroll, -> { order(created_at: :desc) }, inverse_of: :client
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :cpf, presence: true
  validates :cpf, uniqueness: true
  validate :cpf_validation
  validate :check_ban

  enum status: { active: 0, banned: 900 }

  def cpf_get_status
    return unless CPF.valid?(cpf)

    response = Faraday.get "http://subsidiaries/api/v1/banned_user/#{cpf}"

    return unless response.status == 200

    case response.body
    when 'true'
      self.status = 'banned'
    when 'false'
      self.status = 'active'
      false
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

  private

  def cpf_validation
    return if CPF.valid?(cpf)

    errors.add(:cpf, :cpf_invalid)
  end

  def check_ban
    if banned?
      errors.add(:status, 'teste')
    elsif status.blank?
      errors.add(:status, 'ocorreu um erro, tente novamente mais tarde')
    end
  end
end
