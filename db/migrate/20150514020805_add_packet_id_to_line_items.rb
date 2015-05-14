class AddPacketIdToLineItems < ActiveRecord::Migration
  
  def change
    add_column :line_items, :packet_id, :integer
  end

end
