class UserArmy < ActiveRecord::Base
  belongs_to :army
  belongs_to :user
end
