class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.text :title, null: false
      t.string   "image_url",  limit: 255

      t.timestamps null: false
    end
  end
end
