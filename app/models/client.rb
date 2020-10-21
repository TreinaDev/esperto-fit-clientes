class Client < ApplicationRecord
  has_one :enroll, -> { order(created_at: :desc) }, inverse_of: :client
  has_one :profile, through: :enroll
  has_many :order_appointments, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :cpf, :status, presence: true
  validates :cpf, uniqueness: true
  validate :cpf_validation
  before_validation :set_status, on: :create
  before_validation :clean_cpf

  enum status: { active: 0, banned: 900 }

  def auth_allowed?
    return false if cpf_banned?.nil?

    case cpf_banned?
    when true
      banned!
      false
    when false
      active!
    end
  end

  def cpf_banned?
    response = Faraday.get "http://subsidiaries/api/v1/banned_user/#{CPF.new(cpf).stripped}"

    return nil if response.status != 200

    return false if response.body == 'false'

    return true if response.body == 'true'
  end

  def partner?
    PartnerClient.new(self).partner_client?
  end

  def domain
    email.split('@').last
  end

  def already_enrolled?
    enroll.present?
  end

  def active_for_authentication?
    super && auth_allowed?
  end

  def inactive_message
    'Você foi banido'
  end

  private

  def cpf_validation
    return if CPF.valid?(cpf)

    errors.add(:cpf)
  end

  def clean_cpf
    self[:cpf] = CPF.new(cpf).stripped
  end

  def set_status
    return unless CPF.valid?(cpf)

    case cpf_banned?
    when true
      self.status = 'banned'
    when false
      self.status = 'active'
    end
  end
end
