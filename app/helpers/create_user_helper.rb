module CreateUserHelper

  def create_new_user(user)
    add_user_structures(user)
    add_user_stats(user)
  end

  def add_user_structures(user)
    # checkin = Checkin.new user: @user, location: @location, source_id: source_id
    structures = Structure.all
    structures.each do |s|
      us = UserStructure.new user: user, structure: s, num: 1
      us.save
    end
  end

  def add_user_stats(user)
    user.favor = 50
    user.gold = 300
    user.mana = 300
    user.uncollected_gold = 0
    user.uncollected_mana = 0
    user.orb_count = 3
    user.orb_updated_at = Time.now
    user.land = 5
    user.explore_end = Time.now-1.minute
    user.is_exploring = false
    user.explore_start = Time.now-2.minute
    user.touch(:last_collect_gold_at)
    user.touch(:last_collect_mana_at)
    user.save
  end
end