class EnrollsController < ApplicationController
  before_action :authenticate_client!
  before_action :check_already_enrolled

  def new
    @enroll = Enroll.new
    @subsidiary = Subsidiary.find(params[:subsidiary_id])
    @payment_options = PaymentOption.all
  end

  def create
    @enroll = Enroll.new(enroll_params_create)
    if @enroll.save
      redirect_to root_path, notice: t('.successfully')
    else
      @subsidiary = Subsidiary.find(@enroll.subsidiary_id)
      @payment_options = PaymentOption.all
      redirect_invalid
    end
  end

  def confirm
    @enroll = Enroll.new(enroll_params_confirm)
    return if @enroll.valid?

    @subsidiary = Subsidiary.find(params[:subsidiary_id])
    @payment_options = PaymentOption.all
    redirect_invalid
  end

  private

  def enroll_params_confirm
    params.require(:enroll).permit(:plan_id, :payment_option_id)
          .merge(subsidiary_id: params[:subsidiary_id], client_id: current_client.id)
  end

  def enroll_params_create
    params.require(:enroll).permit(:plan_id, :payment_option_id, :subsidiary_id, :client_id)
  end

  def check_already_enrolled
    redirect_to root_path, notice: t('.already_enrolled') if current_client.already_enrolled?
  end

  def redirect_invalid
    if @subsidiary
      render :new
    else
      redirect_to root_path, notice: t('.subsidiary_not_found')
    end
  end
end
