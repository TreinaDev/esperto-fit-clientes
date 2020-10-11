class Clients::OrderedAppointmentsController < ApplicationController
  def index
    @ordered_appointments = OrderAppointment.where(client: current_client)
  end
end
