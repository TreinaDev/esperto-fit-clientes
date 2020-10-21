class OrderAppointmentsController < ApplicationController
  def index
    @appointments = Appointment.available
  end

  def show
    @appointment = Appointment.find(params[:id])
  end

  def create
    appointment = Appointment.find(params[:appointment_id])
    @order_appointment = OrderAppointment.create!(appointment: appointment, client: current_client)
    appointment.update!(status: :ordered)
    redirect_to order_appointments_path(appointment), notice: 'Agendamento realizado com sucesso'
  end
end
