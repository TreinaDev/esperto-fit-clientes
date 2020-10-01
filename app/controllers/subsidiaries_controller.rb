class SubsidiariesController < ApplicationController
  def show
    @subsidiary = Subsidiary.find
    # Ajustar quando mudar o model
  end
end
