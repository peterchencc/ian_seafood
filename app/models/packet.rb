class Packet < ActiveRecord::Base
  validates_presence_of :title, :product_id
  belongs_to :product

  def final_price
    self.price + self.product.price    
  end
end
