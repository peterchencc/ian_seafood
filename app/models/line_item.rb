class LineItem < ActiveRecord::Base

  validates_presence_of :product

  belongs_to :product
  belongs_to :cart
  belongs_to :order

  def amount
    self.qty * self.product.price
  end

end
