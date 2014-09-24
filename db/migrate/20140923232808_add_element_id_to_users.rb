class AddElementIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :element_id, :integer
  end
end
