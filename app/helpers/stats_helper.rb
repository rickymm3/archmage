module StatsHelper

  def town_center_stats

  end

  def alter_stats

  end

  def barracks_stats

  end

  def bank_stats

  end

  def mana_core_stats

  end

  def get_orb_count
    #update war_orbs here
    current_user.orb_count
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
    if current_user.update_attributes(is_exploring:false, land:current_user.land+land)
      current_user.user_notifications.create(notification_id:1, num1: land, viewed:false)
    end
  end

  def gold_time_left
    (current_user.gold_collect_again_at) - Time.now
  end

  def mana_time_left
    (current_user.mana_collect_again_at) - Time.now
  end

  def update_collectors(user = current_user)
    gold_collect = user.gold_collect_again_at
    mana_collect = user.mana_collect_again_at

    while gold_collect < Time.now
      if user.uncollected_gold+@gold_per_refresh < @max_carry_gold
        gold_collect = gold_collect+@collect_time
        user.update_attributes( uncollected_gold: user.uncollected_gold+@gold_per_refresh, gold_collect_again_at:gold_collect)
        user.user_notifications.create(notification_id:3, num1: @gold_per_refresh )
      else
        user.update_attributes( uncollected_gold: @max_carry_gold, gold_collect_again_at: Time.now-1.minute)
        break
      end
    end

    while mana_collect < Time.now
      if user.uncollected_mana+@mana_per_refresh < @max_carry_mana
        mana_collect = mana_collect+@collect_time
        user.update_attributes( uncollected_mana: user.uncollected_mana+@mana_per_refresh, mana_collect_again_at:mana_collect)
        user.user_notifications.create(notification_id:4, num1: @mana_per_refresh )
      else
        user.update_attributes( uncollected_mana: @max_carry_mana, mana_collect_again_at: Time.now-1.minute)
        break
      end
    end
  end

  def get_gold_cost(s)
    us = current_user.user_structures.where(structure_id:s.id).first
    roundup(s.gold_cost*us.num*((s.gold_multiple)**us.num))
  end

  def get_mana_cost(s)
    us = current_user.user_structures.where(structure_id:s.id).first
    roundup(s.mana_cost*us.num*((s.mana_multiple)**us.num))
  end

  def get_page_variables
    #i made this to dramatically limit the amount of queries used to get these
    @num_town_centers = current_user.user_structures.where(structure_id:1).first.num
    @num_alters = current_user.user_structures.where(structure_id:2).first.num
    @num_barracks = current_user.user_structures.where(structure_id:3).first.num
    @num_banks = current_user.user_structures.where(structure_id:4).first.num
    @num_mana_core = current_user.user_structures.where(structure_id:5).first.num

    @max_carry_gold = max_carry_gold(@num_banks, @num_town_centers)
    @max_carry_mana = max_carry_mana(@num_mana_core, @num_town_centers, @num_alters)
    @gold_per_refresh = get_structure_gold_per_hour(@num_town_centers, @num_banks)
    @mana_per_refresh = get_structure_mana_per_hour(@num_alters, @num_town_centers, @num_mana_core)
    @mana_capacity = mana_capacity(@num_alters, @num_town_centers, @num_mana_core)

    @max_population = get_max_population(@num_town_centers, @num_barracks)
    @current_population = get_current_population

    @explore_time = 10.minutes
    @collect_time = 15.minutes
  end

  def get_max_population(num_town_centers, num_barracks)
    roundup((num_town_centers*5 + num_barracks*10)*2.5)
  end

  def get_current_population
    pop = 0
    current_user.user_armies.each do |unit|
      pop = pop + (unit.number_owned * current_user.armies.where(user_armies:{army_id:unit.id}).first.population)
    end
    pop
  end

  def max_carry_gold(num_banks,num_town_center)
    (num_banks * 2000) + (num_town_center * 200)
  end

  def max_carry_mana(num_mana_core, num_town_center, num_alters)
    (num_mana_core * 500) + (num_town_center * 100) + (num_alters * 150)
  end

  def get_structure_gold_per_hour(num_town_centers, num_banks)
    (num_town_centers * 100) + (num_banks * 500)
  end

  def get_structure_mana_per_hour(num_alters, num_town_centers, num_mana_core)
    (num_alters * 100) + (num_town_centers * 10) + (num_mana_core*50)
  end

  def mana_capacity(num_alters, num_town_centers, num_mana_core)
    mana_capacity = (num_alters * 1500) + (num_town_centers * 100) + (num_mana_core*500)
    current_user.update_attributes(mana:mana_capacity) if mana_capacity < current_user.mana
    mana_capacity
  end

end
