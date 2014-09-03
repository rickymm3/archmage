class AddOrbCountAndOrbUpdatedAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :orb_count, :integer
    add_column :users, :orb_updated_at, :datetime
  end
end
