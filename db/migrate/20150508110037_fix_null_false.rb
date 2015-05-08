class FixNullFalse < ActiveRecord::Migration
  
  def change
    change_column :packets, :video, :string, null: true
    change_column :pictures, :title, :string, null: true
    change_column :products, :in_stock_qty, :integer, null: true
  end

end
