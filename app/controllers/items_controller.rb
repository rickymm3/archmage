class ItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @page = 'items'
  end
end
