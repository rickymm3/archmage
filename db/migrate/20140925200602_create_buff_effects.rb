class CreateBuffEffects < ActiveRecord::Migration
  def change
    create_table :buff_effects do |t|
      t.integer :value
      t.boolean :is_percent, default: false
      t.string :stat_effected
      t.timestamps
    end
  end
end
