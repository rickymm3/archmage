class AddViewedToUserNotification < ActiveRecord::Migration
  def change
    add_column :user_notifications, :viewed, :boolean
  end
end
