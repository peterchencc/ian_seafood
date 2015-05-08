class RenamePackets < ActiveRecord::Migration
  def change
    rename_column :packets, "vedio", "video"
  end
end
