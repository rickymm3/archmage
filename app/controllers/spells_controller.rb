class SpellsController < ApplicationController
  before_action :authenticate_user!

  def index
    @page = 'spells'
  end
end
