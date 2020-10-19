class AppointmentsController < ApplicationController
  before_action :authenticate_personal!, only: %i[index show new create edit update]

  def index
    @appointments = current_personal.appointments
  end

  def show
    @appointment = Appointment.find(params[:id])
  end

  def new
    @appointment = Appointment.new
  end

  def create
    @appointment = current_personal.appointments.build(appointment_params)

    if @appointment.save
      redirect_to @appointment, notice: t('.success')
    else
      render 'new'
    end
  end

  def edit
    @appointment = Appointment.find(params[:id])
  end

  def update
    @appointment = Appointment.find(params[:id])

    if @appointment.update(appointment_params)
      redirect_to @appointment, notice: 'Editado com sucesso'
    else
      render 'edit'
    end
  end

  def cancel
    @appointment = current_personal.appointments.find(params[:id])
    @appointment.update(status: :canceled)
    redirect_to @appointment, notice: 'Agendamento cancelado'
  end

  private

  def appointment_params
    params.require(:appointment).permit(:appointment_date, :price_per_hour)
  end
end
