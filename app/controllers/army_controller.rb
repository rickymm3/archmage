class ArmyController < ApplicationController
  before_action :authenticate_user!
  before_action :get_army
  def index
    @page = 'army'
  end

  private

  def get_army
    @users_army = current_user.armies
  end
end
