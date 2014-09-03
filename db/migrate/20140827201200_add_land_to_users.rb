class AddLandToUsers < ActiveRecord::Migration
  def change
    add_column :users, :land, :integer
  end
end
