class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fb_uid, :string
    add_column :users, :fb_access_token, :string
    add_column :users, :fb_expires_at, :datetime

    add_index :users, :fb_uid
  end
end
