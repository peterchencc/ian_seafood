class LineItem < ActiveRecord::Base

  validates_presence_of :product

  belongs_to :product # product_id
  belongs_to :packet # packet_id
  
  belongs_to :cart
  belongs_to :order

  before_validation :setup_subtotal

  def amount
    if self.packet
      self.qty * self.packet.final_price
    else      
      self.qty * self.product.price
    end
  end

  protected

  def setup_subtotal
    self.subtotal = amount
  end

end
