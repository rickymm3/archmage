class Spell < ActiveRecord::Base
  has_many :user_spells, dependent: :delete_all
  has_many :users, :through => :user_spells

  has_many :spell_buffs
  has_many :buff_effects, :through => :spell_buffs

  scope :target_self, -> { where(target: 'self') }
  scope :target_enemy, -> { where(target: 'enemy') }
  scope :target_friend, -> { where(target: 'friend') }

  class << self
    %w(serenity deforestation).each do |spell|
      spell = spell.capitalize
      define_method spell.to_sym do
        where(name: spell).first
      end
    end
  end

end