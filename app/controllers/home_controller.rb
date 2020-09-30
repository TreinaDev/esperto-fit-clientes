class HomeController < ApplicationController
  def index
    @subsidiaries = Subsidiary.all
  end
end
