class EnrollsController < ApplicationController
  before_action :authenticate_client!

  def new
    @enroll = Enroll.new
    @subsidiary = Subsidiary.find
    # add no futuro find(params[:subsidiary_id])
  end

  def create
    byebug
    @enroll = Enroll.new(enroll_params)
    if @enroll.save
      redirect_to root_path
    else
      render :new
      # Mostrar erros
    end
  end

  def confirm
    @enroll = Enroll.new(enroll_params)
  end

  private

  def enroll_params
    params.require(:enroll).permit(:plan_id, :payment_option)
          .merge(subsidiary_id: params[:subsidiary_id], client_id: current_client.id)
  end
end
