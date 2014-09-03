class StructuresController < ApplicationController
  before_action :authenticate_user!

  def index
    @page = 'structure'
    @structures = Structure.all
  end
end
