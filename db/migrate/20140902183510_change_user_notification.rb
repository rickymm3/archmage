class ChangeUserNotification < ActiveRecord::Migration
  def change
    add_column :user_notifications, :str1, :string
    add_column :user_notifications, :str2, :string
    add_column :user_notifications, :str3, :string
    add_column :user_notifications, :date1, :datetime
    add_column :user_notifications, :date2, :datetime
    add_column :user_notifications, :date3, :datetime
  end
end
