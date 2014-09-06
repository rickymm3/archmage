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
  {name: "Town Center", description: "The focal point of expansion. Build more of these whenever you can!", mana_cost: 100, gold_cost: 100, mana_multiple: "1.5", gold_multiple: "1.5"},
  {name: "Alter", description: "Pray for favor. Increase your overall magic power with more Alters!", mana_cost: 250, gold_cost: 0, mana_multiple: "1.5", gold_multiple: "1.5"},
  {name: "Barracks", description: "With more Barracks, you can train more powerful troops!", mana_cost: 0, gold_cost: 250, mana_multiple: "1.5", gold_multiple: "1.5"},
  {name: "Bank", description: "Banks allow you to collect more gold, and generate it faster.", mana_cost: 0, gold_cost: 500, mana_multiple: "1.5", gold_multiple: "1.5"},
  {name: "Mana Core", description: "Mana Core's retain all unused mana, and increase the overall collection amount", mana_cost: 500, gold_cost: 0, mana_multiple: "1.5", gold_multiple: "1.5"}
])