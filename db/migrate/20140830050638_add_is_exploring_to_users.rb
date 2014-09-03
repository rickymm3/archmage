class AddIsExploringToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_exploring, :boolean
  end
end
