class Appointment < ApplicationRecord
  belongs_to :personal

  validates :personal, :appointment_date, presence: true
end
