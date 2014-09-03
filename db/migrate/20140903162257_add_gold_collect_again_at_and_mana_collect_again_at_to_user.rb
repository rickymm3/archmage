class AddGoldCollectAgainAtAndManaCollectAgainAtToUser < ActiveRecord::Migration
  def change
    add_column :users, :gold_collect_again_at, :datetime
    add_column :users, :mana_collect_again_at, :datetime
  end
end
