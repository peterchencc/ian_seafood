class Order < ActiveRecord::Base

  validates_presence_of :name
  has_many :line_items

  def add_line_items(cart)
    cart.line_items.each do |item|
      self.line_items.build( product_id: item.id, qty: item.qty )
    end
  end

end
