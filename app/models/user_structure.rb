class UserStructure < ActiveRecord::Base
  belongs_to :structure
  belongs_to :user
end
