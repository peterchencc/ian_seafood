class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|

      t.string :name
      t.string :phone
      t.string :address
      t.string :email

      t.timestamps null: false
    end

    add_column :line_items, :order_id, :integer
    add_index :line_items, :order_id
  end

end
