class AddOwnedToUserSpells < ActiveRecord::Migration
  def change
    add_column :user_spells, :owned, :boolean
  end
end
