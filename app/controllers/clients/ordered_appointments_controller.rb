class Clients::OrderedAppointmentsController < ApplicationController
  def index
    @ordered_appointments = OrderAppointment.client_appointment_orders(current_client)
  end
end
