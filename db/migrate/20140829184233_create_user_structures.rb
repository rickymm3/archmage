class CreateUserStructures < ActiveRecord::Migration
  def change
    create_table :user_structures do |t|
      t.integer :user_id
      t.integer :structure_id
      t.integer :num
      t.timestamps
    end
  end
end
