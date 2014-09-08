class CreateUserArmies < ActiveRecord::Migration
  def change
    create_table :user_armies do |t|
      t.integer :army_id
      t.integer :user_id
      t.integer :number_owned

      t.timestamps
    end
  end
end
