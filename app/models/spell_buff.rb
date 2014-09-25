class SpellBuff < ActiveRecord::Base
  belongs_to :spell
  belongs_to :buff_effect
end
