class RemovwLineitemUnitprice < ActiveRecord::Migration
  def change
    remove_column :line_items, :unit_price
  end
end
