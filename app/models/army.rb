class Army < ActiveRecord::Base
  has_many :user_armies
  has_many :users, :through => :user_armies
end
