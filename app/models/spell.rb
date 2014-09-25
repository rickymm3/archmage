class Spell < ActiveRecord::Base
  has_many :user_spells, dependent: :delete_all
  has_many :users, :through => :user_spells

  has_many :spell_buffs
  has_many :buff_effects, :through => :spell_buffs
  #spell
  #battle-single-enemy
  #battle-multiple-element

  scope :target_self, -> { where(target: 'self') }
  scope :target_enemy, -> { where(target: 'enemy') }
  scope :target_friend, -> { where(target: 'friend') }

end