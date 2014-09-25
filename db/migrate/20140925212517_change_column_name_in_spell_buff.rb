class ChangeColumnNameInSpellBuff < ActiveRecord::Migration
  def change
    rename_column :spell_buffs, :buff_id, :buff_effect_id
  end
end
