class LineItem < ActiveRecord::Base

  belongs_to :product
  belongs_to :cart

  def amount
    self.qty * self.product.price
  end

end
