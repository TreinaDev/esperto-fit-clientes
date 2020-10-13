class Api::V1::ClientsController < ActionController::API
  def index
    @clients = Client.all
    render json: @clients, status: :ok
  end

  def show
    @client = Client.find(params[:id])
    render json: @client if @client
  rescue ActiveRecord::RecordNotFound
    render status: :not_found, json: 'Cliente não encontrado'
  end
end
