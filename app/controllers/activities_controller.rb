class ActivitiesController < ApplicationController

  #activities updates different attributes (like user.attributes) using PUT

  def explore
    #have to run check
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
            notification_id: 2,
            date1: timenow,
            date2: (timenow + 3.hour),
        )
        redirect_to root_path
      end
    end
  end

  def collect
    timenow = Time.now
    uncollected_gold = current_user.uncollected_gold
    uncollected_mana = current_user.uncollected_mana

    if params[:resource] === 'gold'
      if current_user.update_attributes(
          last_collect_gold_at: timenow,
          gold_collect_again_at: timenow+15.minutes,
          uncollected_gold:0,
          gold: current_user.gold + uncollected_gold)
        current_user.user_notifications.create(
            notification_id: 5,
            num1: uncollected_gold
        )
      end
    end

    if params[:resource] === 'mana'
      if uncollected_mana+current_user.mana > mana_capacity
        #add a confirm dialog because you can sap your mana while overfilling mana
        mana = mana_capacity
      else
        mana = current_user.mana + uncollected_mana
      end
      if current_user.update_attributes(
          last_collect_mana_at: timenow,
          mana_collect_again_at: timenow+15.minutes,
          uncollected_mana:0,
          mana: mana)
        current_user.user_notifications.create(
            notification_id: 6,
            num1: uncollected_mana
        )
      end
    end
    redirect_to root_path
  end

end
