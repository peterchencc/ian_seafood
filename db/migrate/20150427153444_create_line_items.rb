class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :product_id, null: false
      t.integer :cart_id
      t.integer :qty, default: 1
      t.timestamps null: false
    end

    add_index :line_items, :cart_id
    add_index :line_items, :product_id
  end
end
