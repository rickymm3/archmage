class ActivitiesController < ApplicationController

  #activities updates different attributes (like user.attributes) using PUT
  include StatsHelper

  def explore
    #have to run check
    timenow = Time.now
    if current_user.is_exploring
      redirect_to root_path, :notice => "You are already exploring"
    else
      #start the update on the user model
      update = current_user.update_attributes(
          explore_start: timenow,
          explore_end: timenow + @explore_time,
          is_exploring: true
      )
      if update
        #be sure to create the notification!
        current_user.user_notifications.create(
            notification_id: 2,
            date1: timenow,
            date2: (timenow + @explore_time),
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
          gold_collect_again_at: timenow+@collect_time,
          uncollected_gold:0,
          gold: current_user.gold + uncollected_gold)
        current_user.user_notifications.create(
            notification_id: 5,
            num1: uncollected_gold
        )
      end
    end

    if params[:resource] === 'mana'
      if uncollected_mana+current_user.mana > @mana_capacity
        #add a confirm dialog because you can sap your mana while overfilling mana
        mana = @mana_capacity
      else
        mana = current_user.mana + uncollected_mana
      end
      if current_user.update_attributes(
          last_collect_mana_at: timenow,
          mana_collect_again_at: timenow+@collect_time,
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

  def build
    #possibly add amount of lands you wish to add...params[:num_of_lands]
    structure = Structure.find(params[:structure_id])
    us = current_user.user_structures.where(structure_id: structure.id).first
    gold_cost = get_gold_cost(structure)
    mana_cost = get_mana_cost(structure)
    if gold_cost <= current_user.gold && mana_cost <= current_user.mana
      if get_used_land < current_user.land
        us_update = us.update_attributes(
            num:us.num+1)
        u_update = current_user.update_attributes(
            gold:current_user.gold-gold_cost,
            mana:current_user.mana-mana_cost
        )
        if us_update && u_update
          current_user.user_notifications.create(
              notification_id:7,
              num1: 1, #lands
              num2: us.num,
              str1: structure.name
          )
        end
      else
        notice = "You don't have enough land"
      end
    else
      notice = "You dont have enough resources"
    end
    redirect_to structures_path, notice:notice
  end

  def destroy
    structure = Structure.find(params[:structure_id])
    us = current_user.user_structures.where(structure_id: structure.id).first
    save = us.update_attributes(num:us.num-1)
    if save
      current_user.user_notifications.create(
          notification_id:8,
          num1: 1, #lands
          num2: us.num,
          str1: structure.name
      )
    end
    redirect_to structures_path
  end

  def disband
    redirect_to army_path
  end

end
