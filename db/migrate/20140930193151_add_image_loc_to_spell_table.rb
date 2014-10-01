class AddImageLocToSpellTable < ActiveRecord::Migration
  def change
    add_column :spells, :image_loc, :string, default: "generic-buff.png"
  end
end
