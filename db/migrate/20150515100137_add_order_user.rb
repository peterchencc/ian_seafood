class AddOrderUser < ActiveRecord::Migration
  def change
    add_column :orders, :auth_token, :string
    add_column :orders, :user_email, :string
  end
end
