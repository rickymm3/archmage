class AddFavorToUser < ActiveRecord::Migration
  def change
    add_column :users, :favor, :integer
  end
end
