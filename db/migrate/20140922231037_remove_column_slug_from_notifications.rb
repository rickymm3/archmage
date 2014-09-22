class RemoveColumnSlugFromNotifications < ActiveRecord::Migration
  def change
    remove_column :notifications, :slug
  end
end
