class AddManaCostToSpell < ActiveRecord::Migration
  def change
    add_column :spells, :mana_cost, :integer
    add_column :spells, :mana_upkeep, :integer
  end
end
