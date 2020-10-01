class EnrollsController < ApplicationController
  def new
    @enroll = Enroll.new
    @subsidiary = Subsidiary.find

    # Alterar essa linha para find params no futuro
    @enroll.subsidiary_id = @subsidiary.id

    @payment_options = PaymentOption.all
  end

  def create
    @enroll = Enroll.new(enroll_params)
  end

  private

  def enroll_params
    params.require(:enroll).permit(:plan_id, :payment_option_id)
    # Adicionar current_user
  end
end
