class AddExploreStartToUsers < ActiveRecord::Migration
  def change
    add_column :users, :explore_start, :datetime
    add_column :users, :explore_end, :datetime
  end
end
