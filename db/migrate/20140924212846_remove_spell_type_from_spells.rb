class RemoveSpellTypeFromSpells < ActiveRecord::Migration
  def change
    remove_column :spells, :spell_type_id, :integer
    add_column :spells, :spell_target, :string
  end
end
