class AddCostToArmies < ActiveRecord::Migration
  def change
    add_column :armies, :cost, :integer, default: 100
  end
end
