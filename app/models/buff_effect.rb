class BuffEffect < ActiveRecord::Base
  has_many :spell_buffs
  has_many :spells, :through => :spell_buffs
end
