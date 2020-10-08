class Api::V1::ClientsController < ActionController::API
  def index
    @clients = Client.all
    render json: @clients, status: :ok
  end
end
