class AddDescriptionToStructures < ActiveRecord::Migration
  def change
    add_column :structures, :description, :string
  end
end
