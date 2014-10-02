class ChangeLastUpdateAtInUsers < ActiveRecord::Migration
  def change
    change_column :users, :last_update_at, :datetime, :default => Time.now.beginning_of_hour
  end
end
