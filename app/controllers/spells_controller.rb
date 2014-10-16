class SpellsController < ApplicationController
  before_action :authenticate_user!
  before_action :owned_spells, :index

  def index
    @page = 'spells'
  end

  def cast
    #params[:id] = #id
    @spell = Spell.find(params[:id])
  end

  private

  def useable_spells
    @spells = current_user.user_spells.where(owned:true)
    @spells = Hash.new
    @spells['self'] = Spell.target_self
    @spells['enemy'] = Spell.target_enemy
    @spells['friend'] = Spell.target_friend
  end

  def owned_spells
    @owned = current_user.user_spells.where(owned:true)
    if @owned.present?
      spells = @owned.map { |us| us.spell }
    else
      spells = {}
    end
    @spells = Hash.new
    s_self = Array.new
    enemy = Array.new
    friend = Array.new
    spells.each do |spell|
      s_self.push(spell) if spell.target == 'self'
      enemy = spell if spell.target == 'enemy'
      friend = spell if spell.target == 'friend'
    end
    @spells['self'] = s_self
  end

end
