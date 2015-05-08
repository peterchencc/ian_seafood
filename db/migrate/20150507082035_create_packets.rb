class CreatePackets < ActiveRecord::Migration
  def change
    create_table :packets do |t|

      t.string :title, :null => false
      t.text :content
      t.integer :product_id, null: false
      t.integer :price, null: false
      t.string :vedio, :null => false
      t.text :ingredient

      t.timestamps null: false
    end
    add_index :packets, :product_id
  end
end
