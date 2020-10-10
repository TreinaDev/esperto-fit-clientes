class Appointment < ApplicationRecord
  belongs_to :personal

  validates :personal, :appointment_date, :price_per_hour, presence: true

  def owner?(current_personal)
    personal == current_personal
  end
end
