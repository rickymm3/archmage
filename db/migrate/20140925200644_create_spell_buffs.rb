class CreateSpellBuffs < ActiveRecord::Migration
  def change
    create_table :spell_buffs do |t|
      t.integer :spell_id
      t.integer :buff_id

      t.timestamps
    end
  end
end
