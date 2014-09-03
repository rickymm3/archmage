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
    user.gold = 300
    user.mana = 300
    user.orb_count = 3
    user.land = 5
    user.touch(:collect_gold)
    user.touch(:collect_mana)
    user.save
  end
end