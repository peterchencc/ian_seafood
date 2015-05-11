class CreateAbouts < ActiveRecord::Migration
  def change
    create_table :abouts do |t|
      t.string :title
      t.string :content
      t.string :phone
      t.string  :email
      t.string  :atm_account
      t.timestamps null: false
    end
  end
end
