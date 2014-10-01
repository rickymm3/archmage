class AddGoldCostAndGoldUpkeepToSpell < ActiveRecord::Migration
  def change
    add_column :spells, :gold_cost, :integer, default: 0
    add_column :spells, :gold_upkeep, :integer, default: 0
  end
end
