class AddImgToProduct < ActiveRecord::Migration
  def change
    remove_column :products, :image_url
    add_attachment :products, :image
  end
end
