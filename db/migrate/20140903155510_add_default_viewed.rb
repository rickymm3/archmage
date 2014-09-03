class AddDefaultViewed < ActiveRecord::Migration
  def change
    change_column :user_notifications, :viewed, :boolean, default:false
  end
end
