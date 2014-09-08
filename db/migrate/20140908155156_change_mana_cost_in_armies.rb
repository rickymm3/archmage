class ChangeManaCostInArmies < ActiveRecord::Migration
  def change
    rename_column :armies, :mana_cost, :mana_upkeep
  end
end
