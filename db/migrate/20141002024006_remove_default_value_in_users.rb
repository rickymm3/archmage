class RemoveDefaultValueInUsers < ActiveRecord::Migration
  def change
    change_column_default :users, :last_update_at, nil
  end
end
