class OrderAppointmentsController < ApplicationController
  def index
    @appointments = Appointment.all
  end

  def create
    appointment = Appointment.find(params[:appointment_id])
    @order_appointment = OrderAppointment.create!(appointment: appointment, client: current_client)
    appointment.update!(status: :ordered)
    redirect_to appointment_path(appointment), notice: 'Agendamento realizado com sucesso'
  end
end
