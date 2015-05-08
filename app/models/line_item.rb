class LineItem < ActiveRecord::Base

  validates_presence_of :packet

  belongs_to :product # product_id
  belongs_to :packet # packet_id
  
  belongs_to :cart
  belongs_to :order

  def amount
    self.qty * self.packet.final_price
  end

end
