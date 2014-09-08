class RecruitController < ApplicationController

  before_action :get_units_list, :index

  def index
    @page = "recruit"
  end

  private

  def get_units_list
    @units_list = Army.all
  end

end
