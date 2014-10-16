module StatsHelper

  # TODO organize all these stat methods into appropriate models

  def spell_form_builder(spell)
    case spell.target
      when 'self'
        render 'spells/forms/self', spell:spell
      when 'enemy'
        render 'spells/forms/enemy', spell:spell
      when 'friend'
        render 'spells/forms/friend', spell:spell
    end
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

  def time_till_next_update
    #replace with gem (https://github.com/radar/dotiw)
    distance_of_time_in_words(Time.now, (current_user.last_update_at.end_of_hour + 1.seconds), include_seconds: true)
  end

  def calculate_favor(change, favor = current_user.favor)
    favor = favor + change + @static_favor_buff
    if favor > 100
      favor = 100
    elsif favor < 0
      favor = 0
    end
    favor
  end

  def player_gold_is_maxed(earned_gold)
    current_user.uncollected_gold+@gold_per_refresh+earned_gold >= @max_carry_gold
  end

  def player_mana_is_maxed(earned_mana)
    current_user.uncollected_mana+@mana_per_refresh+earned_mana >= @max_carry_mana
  end

  def turns_passed_since_last_update
    ((Time.now.beginning_of_hour - current_user.last_update_at)/60/60).to_i
  end

  def player_update(turns_passed)
    earned_gold = 0
    earned_mana = 0
    favor = current_user.favor
    turns = turns_passed
    favor_change = 0
    while turns > 0
#-----#calculate favor-----------------------
      if @gold_per_refresh <= 0
        updown = 'lost'
        favor = calculate_favor(-5, favor)
        favor_change = favor_change - 5 + @static_favor_buff
      else
        updown = 'gained'
        favor = calculate_favor(1, favor) if @gold_per_refresh >= 0
        favor_change = favor_change + 1 + @static_favor_buff
      end
#-----#calculate gold income-----------------
      if player_gold_is_maxed(earned_gold)
        earned_gold = @max_carry_gold
      else
        earned_gold = earned_gold + @gold_per_refresh
      end
#-----#calculated mana income----------------
      if player_mana_is_maxed(earned_mana)
        earned_mana = @max_carry_mana
      else
        earned_mana = earned_mana + @mana_per_refresh
      end

      turns = turns-1
      if turns == 0
        current_user.update_attributes( uncollected_gold: earned_gold,
                                        uncollected_mana: earned_mana,
                                        favor:favor,
                                        last_update_at: Time.now.beginning_of_hour)
        current_user.user_notifications.create(notification_id:12, num1: turns_passed, num2:earned_gold , num3:earned_mana)
        current_user.user_notifications.create(notification_id: 9, str1: updown, num1: favor_change.abs, num2: turns_passed)
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

  def disable_buffs
    user_spells = current_user.user_spells
    user_spells.each do |spell|
      if spell.active
        spell.update_attributes(active: false) if spell.ends < Time.now
      end
    end
  end

  def set_page_variables
    disable_buffs
    @static_favor_buff = get_buffs('favor', false).to_f || 0
    @static_buff_gold = get_buffs('gold', false).to_f || 0
    @static_buff_mana = get_buffs('mana', false).to_f || 0
    @percent_buff_gold = get_buffs('gold', true).to_f || 0
    @percent_buff_mana = get_buffs('mana', true).to_f || 0
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
    current_user.user_armies.each do |ua|
      pop = pop + (ua.number_owned * get_unit_user_population(ua))
    end
    pop
  end

  def get_unit_user_population(ua)
    current_user.armies.where(user_armies:{army_id:ua.army_id}).first.population
  end

  def get_unit_user_gold_cost
    userarmies = UserArmy.joins(:army).select("armies.population", "armies.gold_upkeep", "armies.mana_upkeep", :number_owned).where(user_id:current_user.id)
    i = 0
    userarmies.each do |userarmy|
      i = i + userarmy.number_owned * userarmy.gold_upkeep
    end
    i
  end

  def max_carry_gold(num_banks,num_town_center)
    (num_banks * 2000) + (num_town_center * 200)
  end

  def max_carry_mana(num_mana_core, num_town_center, num_alters)
    (num_mana_core * 500) + (num_town_center * 100) + (num_alters * 150)
  end

  def get_structure_gold_per_hour(num_town_centers, num_banks)
    num = (num_town_centers * 100) + (num_banks * 500) - get_unit_user_gold_cost
    num + @static_buff_gold
    num = num.to_f * (1+(@percent_buff_gold.to_f/100))
    num = 0 if num < 0
    num.to_i
  end

  def get_structure_mana_per_hour(num_alters, num_town_centers, num_mana_core)
    (num_alters * 100) + (num_town_centers * 10) + (num_mana_core*50)
  end

  def mana_capacity(num_alters, num_town_centers, num_mana_core)
    mana_capacity = (num_alters * 1500) + (num_town_centers * 100) + (num_mana_core*500)
    current_user.update_attributes(mana:mana_capacity) if mana_capacity < current_user.mana
    mana_capacity
  end

  def user_spell_level
    5
  end

  def user_should_show_recruit(unit)
    unit.barracks_lvl
    true if unit.barracks_lvl <= @num_barracks # && unit.spell_lvl <= user_spell_level
  end

  def cost_of_units
    user.armies.joins(:user_armies).each do |a|
      a
    end
  end

  def get_user_buffs
    current_user.user_spells.where(active:true)
  end

  def user_can_cast?(spell)
    current_user.mana > spell.mana_cost && current_user.gold > spell.gold_cost
  end

  def user_can_recruit?(totalcost)
    current_user.gold > totalcost
  end

  def get_buffs(stat_effected, percent)
    current_user.user_spells.where(active:true).flat_map do |us|
      us.spell.buff_effects.where(stat_effected:stat_effected, is_percent:percent).map(&:value)
    end.reduce(&:+)
  end

end
