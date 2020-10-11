class OrderAppointment < ApplicationRecord
  belongs_to :client
  belongs_to :appointment

  delegate :appointment_date, to: :appointment

  scope :client_appointment_orders, ->(client) { where(client: client) }
end
