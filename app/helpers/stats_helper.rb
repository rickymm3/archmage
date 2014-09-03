module StatsHelper

  def get_orb_count
    #update war_orbs here
    current_user.orb_count
  end

  def run_full_update
    @collection = get_collection_data
  end

  def get_collection_data
    Hash.new(collect_gold: current_user.collect_gold, collect_mana: current_user.collect_mana)
  end

  def get_used_land
    total = 0
    current_user.user_structures.each do |s|
      total = total + s.num
    end
    total
  end

  def complete_explore
    land = 1
    un = current_user.user_notifications.create(notification_id:1, num1: land, viewed:false)
    if un.save
      current_user.update_attributes(is_exploring:false)
    end
  end

  def gold_time_left
    (current_user.gold_collect_again_at) - Time.now
  end

  def mana_time_left
    (current_user.mana_collect_again_at) - Time.now
  end

  def update_collectors(user = current_user)
    gph = get_structure_gold_per_hour
    mph = get_structure_mana_per_hour
    timenow = Time.now

    gold_collect = user.gold_collect_again_at
    mana_collect = user.mana_collect_again_at

    while gold_collect < Time.now
      if user.uncollected_gold+gph < max_carry_gold
        gold_collect = gold_collect+15.minutes
        user.update_attributes( uncollected_gold: user.uncollected_gold+gph, gold_collect_again_at:gold_collect)
        user.user_notifications.create(notification_id:3, num1: gph )
      else
        user.update_attributes( uncollected_gold: max_carry_gold)
        break
      end
    end

    while mana_collect < Time.now
      if user.uncollected_mana+mph < max_carry_mana
        mana_collect = mana_collect+15.minutes
        user.update_attributes( uncollected_mana: user.uncollected_mana+mph, mana_collect_again_at:mana_collect)
        user.user_notifications.create(notification_id:4, num1: mph )
      else
        user.update_attributes( uncollected_mana: max_carry_mana)
        break
      end
    end


    # if times_gold_update > 0
    #   times_gold_update.times do
    #     if user.uncollected_gold+gph < max_gold
    #       new_gold = (user.uncollected_gold + gph)
    #       user.update_attributes( uncollected_gold: new_gold, gold_collect_again_at:timenow+15.minutes)
    #       # user collected num1 gold in taxes
    #       user.user_notifications.create(notification_id:3, num1: gph )
    #     else
    #     end
    #   end
    # end
    # if times_mana_update > 0
    #   times_mana_update.times do
    #     if user.uncollected_mana+mph < max_mana
    #       new_mana = (user.uncollected_mana + mph)
    #       user.update_attributes( uncollected_mana: new_mana, mana_collect_again_at:timenow+15.minutes)
    #       # user collected num1 gold in taxes
    #       user.user_notifications.create(notification_id:4, num1: mph )
    #     else
    #       user.update_attributes( uncollected_mana: max_mana, mana_collect_again_at:timenow+15.minutes)
    #     end
    #   end
    # end
  end


  #stubbed until structures are added
  def max_carry_gold
    5000
  end

  def max_carry_mana
    1500
  end
  def get_structure_gold_per_hour
    300
  end

  def get_structure_mana_per_hour
    150
  end

  def mana_capacity
    300
  end

end
