class SubsidiariesController < ApplicationController
  def show
    @subsidiary = Subsidiary.find
    # Ajustar quando mudar o model
  end

  def search
    @subsidiaries = Subsidiary.search(params[:q])
  end
end
