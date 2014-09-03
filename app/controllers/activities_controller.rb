class ActivitiesController < ApplicationController

  #activities updates different attributes (like user.attributes) using PUT

  def explore
    #have to run check
    notification = Notification.find(2)
    timenow = Time.now
    if current_user.is_exploring
      redirect_to root_path, :notice => "You are already exploring"
    else
      #start the update on the user model
      update = current_user.update_attributes(
          explore_start: timenow,
          explore_end: timenow + 3.hour,
          is_exploring: true
      )
      if update
        #be sure to create the notification!
        current_user.user_notifications.create(
                notification_id: notification.id,
                date1: timenow,
                date2: (timenow + 3.hour),
        )
        redirect_to root_path
      end
    end
  end



end
