Army.create!([
  {name: "Dopey Squire", barracks_lvl: 1, is_summon: false, description: "What a dopey squire. But he's not useless in a fight", gold_upkeep: 5, mana_upkeep: 0, lvl: 1, str: 10, spd: 5, int: 0, population: 1},
  {name: "Core Hound", barracks_lvl: 2, is_summon: false, description: "Hounds bred in flame. Their branded flesh marks their power", gold_upkeep: 20, mana_upkeep: 5, lvl: 2, str: 20, spd: 10, int: 5, population: 5}
])
Notification.create!([
  {message: "user's units returned from exploring and discovered num1 land!"},
  {message: "user began exploring at date1.  Your expedition will return in date2"},
  {message: "user collected num1 gold in taxes"},
  {message: "user collected num1 mana by channeling the powah"},
  {message: "user collected num1 gold"},
  {message: "user collected num1 mana"},
  {message: "user has used num1 land to build a str1. You now have num2"},
  {message: "user has destroyed num1 str1"}
])
Structure.create!([
  {name: "Town Center", description: "The focal point of expansion. Build more of these whenever you can!", mana_cost: 100, gold_cost: 100, mana_multiple: "1.2", gold_multiple: "1.2"},
  {name: "Alter", description: "Pray for favor. Increase your overall magic power with more Alters!", mana_cost: 250, gold_cost: 0, mana_multiple: "1.2", gold_multiple: "1.2"},
  {name: "Barracks", description: "With more Barracks, you can train more powerful troops!", mana_cost: 0, gold_cost: 250, mana_multiple: "1.2", gold_multiple: "1.2"},
  {name: "Bank", description: "Banks allow you to collect more gold, and generate it faster.", mana_cost: 0, gold_cost: 500, mana_multiple: "1.2", gold_multiple: "1.2"},
  {name: "Mana Core", description: "Mana Core's retain all unused mana, and increase the overall collection amount", mana_cost: 300, gold_cost: 0, mana_multiple: "1.1", gold_multiple: "1.2"}
])
