class Enroll < ApplicationRecord
  belongs_to :client
  belongs_to :payment_option
  validates :plan_id, :payment_option_id, :subsidiary_id, :client_id, presence: true

  def plan
    Plan.find
  end
end
