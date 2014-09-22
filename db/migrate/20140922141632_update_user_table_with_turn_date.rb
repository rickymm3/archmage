class UpdateUserTableWithTurnDate < ActiveRecord::Migration
  def change
    remove_column :users, :gold_collect_again_at
    remove_column :users, :mana_collect_again_at
    add_column :users, :last_update_at, :datetime, default: Time.now
  end
end
