class ArmyController < ApplicationController
  before_action :authenticate_user!

  def index
    @page = 'army'
  end
end
