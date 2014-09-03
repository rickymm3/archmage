class Structure < ActiveRecord::Base
  has_many :user_structures
  has_many :users, :through => :user_structures
end
