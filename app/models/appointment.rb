class Appointment < ApplicationRecord
  belongs_to :personal
  has_one :order_appointment, dependent: :destroy

  enum status: { available: 0, ordered: 10, canceled: 20 }

  validates :personal, :appointment_date, :price_per_hour, presence: true
  validate :appointment_date_after_today

  def owner?(current_personal)
    personal == current_personal
  end

  private

  def appointment_date_after_today
    errors.add(:appointment_date) if appointment_date.present? && appointment_date < Time.zone.today
  end
end
