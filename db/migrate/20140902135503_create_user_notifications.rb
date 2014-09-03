class CreateUserNotifications < ActiveRecord::Migration
  def change
    create_table :user_notifications do |t|
      t.integer :user_id
      t.integer :notification_id
      t.integer :num1
      t.integer :num2
      t.integer :num3
      t.integer :num4
      t.integer :num5

      t.timestamps
    end
  end
end
