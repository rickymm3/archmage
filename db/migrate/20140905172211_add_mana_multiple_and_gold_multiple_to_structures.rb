class AddManaMultipleAndGoldMultipleToStructures < ActiveRecord::Migration
  def change
    add_column :structures, :mana_multiple, :decimal, precision: 3, scale:2
    add_column :structures, :gold_multiple, :decimal, precision: 3, scale:2
  end
end
