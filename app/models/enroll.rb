class Enroll < ApplicationRecord
  include EnrollmentsCoupons

  belongs_to :client
  belongs_to :payment_option
  validates :plan_id, :subsidiary_id, presence: true

  def plan
    Plan.find(plan_id)
  end
end
