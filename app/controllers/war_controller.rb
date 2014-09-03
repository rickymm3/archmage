class WarController < ApplicationController
  before_action :authenticate_user!

  def index
    @page = 'war'
  end
end
