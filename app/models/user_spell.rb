class UserSpell < ActiveRecord::Base
  belongs_to :spell
  belongs_to :user
end
