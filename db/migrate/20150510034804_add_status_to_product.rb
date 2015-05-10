class AddStatusToProduct < ActiveRecord::Migration
  def change
    add_column :products, :status, :string, :default => "draft"
  end
end
