class CreateUserSpells < ActiveRecord::Migration
  def change
    create_table :user_spells do |t|
      t.integer :spell_id
      t.integer :user_id
      t.datetime :began
      t.datetime :ends

      t.timestamps
    end
  end
end
