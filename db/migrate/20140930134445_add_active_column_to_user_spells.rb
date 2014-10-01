class AddActiveColumnToUserSpells < ActiveRecord::Migration
  def change
    add_column :user_spells, :active, :boolean, default: false
  end
end
