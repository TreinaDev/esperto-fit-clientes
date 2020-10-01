class SubsidiariesController < ApplicationController
  def search
    @subsidiaries = Subsidiary.search(params[:q])
  end
end
