class SubsidiariesController < ApplicationController
  def show
    @subsidiary = Subsidiary.find(params[:id])
  end

  def search
    @subsidiaries = Subsidiary.search(params[:q])
  end
end
