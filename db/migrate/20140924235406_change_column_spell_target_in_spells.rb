class ChangeColumnSpellTargetInSpells < ActiveRecord::Migration
  def change
    rename_column :spells, :spell_target, :target
  end
end
