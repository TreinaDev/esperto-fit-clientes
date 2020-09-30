class SubsidiariesController < ApplicationController
  def show
    @subsidiary = Subsidiary.find(params[:id])
end
