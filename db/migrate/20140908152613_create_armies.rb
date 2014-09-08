class CreateArmies < ActiveRecord::Migration
  def change
    create_table :armies do |t|
      t.string :name
      t.integer :barracks_lvl
      t.boolean :is_summon, :default => false
      t.string :description
      t.integer :gold_upkeep
      t.integer :mana_cost
      t.integer :lvl
      t.integer :str
      t.integer :spd
      t.integer :int
      t.integer :population

      t.timestamps
    end
  end
end
