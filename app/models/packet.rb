class Packet < ActiveRecord::Base
  validates_presence_of :title, :product_id
  belongs_to :product
end
