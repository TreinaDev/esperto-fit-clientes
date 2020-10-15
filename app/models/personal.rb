class Personal < ApplicationRecord
  has_many :appointments, dependent: :destroy
  has_many :personal_subsidiaries, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, :cref, :cpf, :status, presence: true
  validates :cref, :cpf, uniqueness: true
  validate :cpf_validation
  validates :cref, format: { with: %r{\d{6}-[G|P]/\w{2}} }
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
