class SpellsController < ApplicationController
  before_action :authenticate_user!
  before_action :useable_spells, :index

  def index
    @page = 'spells'
  end

  def cast
    #params[:id] = #id
    @spell = Spell.find(params[:id])
  end

  private

  def useable_spells
    @spells = Hash.new
    @spells['self'] = Spell.target_self
    @spells['enemy'] = Spell.target_enemy
    @spells['friend'] = Spell.target_friend
  end


end
