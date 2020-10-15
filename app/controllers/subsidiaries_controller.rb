class SubsidiariesController < ApplicationController
  def show
    @subsidiary = Subsidiary.find(params[:id])
    add_breadcrumb(@subsidiary.name, subsidiary_path)
  end

  def search
    add_breadcrumb('Busca')
    @subsidiaries = Subsidiary.search(params[:q])
  end
end
