class AlterUser < ActiveRecord::Migration
  def change
    rename_column :users, :collect_gold, :last_collect_gold_at
    rename_column :users, :collect_mana, :last_collect_mana_at
    add_column :users, :uncollected_gold, :integer
    add_column :users, :uncollected_mana, :integer
  end
end
