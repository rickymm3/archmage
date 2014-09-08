class StructuresController < ApplicationController
  before_action :authenticate_user!

  def index
    @page = 'structures'
    @structures = Structure.all
  end

end
