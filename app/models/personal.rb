class Personal < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, :cref, :cpf, presence: true
  validate :validate_cpf
  validates :cref, format: { with: %r{\d{6}-[G|P]/\w{2}} }
  validate :check_ban
  before_validation :cpf_get_status

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

  private

  def validate_cpf
    errors.add(:cpf) if cpf.present? && !CPF.valid?(cpf, strict: true)
  end

  def check_ban
    if banned?
      errors.add(:status, 'teste')
    elsif status.blank?
      errors.add(:status, 'ocorreu um erro, tente novamente mais tarde')
    end
  end
end
