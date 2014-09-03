class AddUsernameToUser < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users,  :user_id, :integer
    add_column :users,  :message, :string
    add_column :users,  :gold, :integer
    add_column :users, :mana, :integer
    add_column :users, :collect_gold, :datetime
    add_column :users, :collect_mana, :datetime
  end
end
