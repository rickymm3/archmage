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
    uncollected_gold = current_user.uncollected_gold if params[:resource] === 'gold'
    uncollected_mana = current_user.uncollected_mana if params[:resource] === 'mana'

    if params[:resource] === 'gold'
      if current_user.update_attributes(
          last_collect_gold_at: timenow,
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
    if params[:num_to_disband].empty?
      redirect_to army_index_path, notice: "Can't be 0"
    end
    num = current_user.user_armies.where(army_id:params[:unit_id]).first.number_owned
    num_to_disband = params[:num_to_disband]
    new = num - num_to_disband.to_i
    if current_user.user_armies.where(army_id:params[:unit_id]).first.update_attributes(number_owned:new)
      #need message
      redirect_to army_index_path, notice: "you disbanded #{num_to_disband} units"
    else
      redirect_to army_index_path, notice: "there was an error, try again"
    end
  end

  def recruit
    #!***!need a check in here that doesn't allow you to pass the population cap!
    if params[:num_to_recruit].empty?
      redirect_to recruit_index_path, notice: "Can't be 0"
    end
    num = 0
    ua = current_user.user_armies.find_or_initialize_by(army_id:params['unit_id'])
    num = ua.number_owned unless ua.number_owned.nil?
    num_to_recruit = params[:num_to_recruit]
    new = num + num_to_recruit.to_i
    if ua.update_attributes(number_owned:new)
      #need message
      redirect_to recruit_index_path, notice: "you recruited #{num_to_recruit} units"
    else
      redirect_to recruit_index_path, notice: "there was an error, try again"
    end

  end

  def payoff
    #this will be instant
    favor = calculate_favor(100)
    current_user.update_attributes(favor:favor)
    current_user.user_notifications.create(
        notification_id:11,
        num1: 10000, #gold - this is dependant on favor
        num2: 100 #favor
    )
    redirect_to morale_index_path

  end

  def party
    #this won't cost anything.  But it will take some number of time to finish
    favor = calculate_favor(15)
    current_user.update_attributes(favor:favor)
    current_user.user_notifications.create(
        notification_id:10,
        num1: 15, #favor
    )
    redirect_to morale_index_path
  end

  def cast
    redirect_to spells_path, notice: "You casted #{params[:spell_id]}"
  end

end
