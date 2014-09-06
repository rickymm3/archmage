class AddManaCostAndGoldCostToStructures < ActiveRecord::Migration
  def change
    add_column :structures, :mana_cost, :integer
    add_column :structures, :gold_cost, :integer
  end
end
