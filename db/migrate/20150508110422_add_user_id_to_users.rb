class AddUserIdToUsers < ActiveRecord::Migration
  
  def change
    
    add_column :line_items, :product_id, :integer, :null => false

    add_column :orders, :user_id, :integer
    add_index :orders, :user_id
  end

end
