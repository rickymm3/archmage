class MarketController < ApplicationController
  before_action :authenticate_user!

  def index
    @page = 'market'
  end
end
