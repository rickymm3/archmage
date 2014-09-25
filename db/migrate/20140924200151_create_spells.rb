class CreateSpells < ActiveRecord::Migration
  def change
    create_table :spells do |t|
      t.string :name
      t.integer :element_id
      t.integer :spell_type_id
      t.string :description

      t.timestamps
    end
  end
end
