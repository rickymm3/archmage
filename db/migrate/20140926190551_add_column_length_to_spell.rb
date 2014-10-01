class AddColumnLengthToSpell < ActiveRecord::Migration
  def change
    add_column :spells, :length, :integer, default: 1
  end
end
