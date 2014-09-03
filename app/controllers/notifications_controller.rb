class NotificationsController < ApplicationController
  def index
    @page = 'notification'
    @usernotifications = UserNotification.where(user_id:current_user.id).order('updated_at DESC')
  end
end
