class Enroll < ApplicationRecord
  include EnrollmentsCoupons

  belongs_to :client
  belongs_to :payment_option
  validates :plan_id, :subsidiary_id, presence: true

  def total_value_with_coupon
    rate = coupon_discount_rate.to_f / 100
    plan = self.plan.monthly_payment

    plan - (plan * rate)
  end

  def plan
    Plan.find(plan_id)
  end
end
