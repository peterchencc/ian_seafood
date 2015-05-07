class AddProductImgurl < ActiveRecord::Migration
  def change
    add_column :products, :image_url, :string, limit: 255
  end
end
