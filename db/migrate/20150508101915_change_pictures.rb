class ChangePictures < ActiveRecord::Migration
  
  def change
    remove_column :pictures, :image_url
    add_attachment :pictures, :image
    
    add_column :pictures, :imageable_type, :string
    add_column :pictures, :imageable_id, :integer

    add_index :pictures, [:imageable_type, :imageable_id]
  end

end
