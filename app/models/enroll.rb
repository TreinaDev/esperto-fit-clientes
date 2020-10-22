class Enroll < ApplicationRecord
  has_one :profile, dependent: :destroy
  belongs_to :client
  belongs_to :payment_option
  validates :plan_id, :subsidiary_id, presence: true

  after_commit :send_to_subsidiary

  def plan
    Plan.find(plan_id, subsidiary_id)
  end

  private

  def send_to_subsidiary
    Faraday.post("#{Rails.configuration.apis[:subsidiaries]}enrollments",
                 serialized.to_json,
                 'Content-Type': 'application/json')
  end

  def serialized
    {
      id: id,
      subsidiary_id: subsidiary_id,
      plan_id: plan_id,
      price: Plan.find(plan_id, subsidiary_id).monthly_payment,
      email: client.email,
      customer_cpf: client.cpf,
      customer_name: client&.profile&.name
    }
  end
end
