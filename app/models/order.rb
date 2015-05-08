class Order < ActiveRecord::Base

  validates_presence_of :name

  belongs_to :user
  has_many :line_items, :dependent => :destroy

  def add_line_items(cart)
    cart.line_items.each do |item|
      self.line_items.build( product_id: item.id, qty: item.qty )
    end
  end

  def total
    self.line_items.sum(:subtotal)
  end

end
