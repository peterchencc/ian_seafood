class Cart < ActiveRecord::Base

  has_many :line_items, :dependent => :destroy

  def add_line_item(product)
    this_line_item = self.line_items.find_by( product_id: product.id )
    if this_line_item
      this_line_item.qty += 1
    else
      this_line_item = line_items.build( product_id: product.id )
    end

    this_line_item
  end

  def total
    self.line_items.to_a.sum{ |i| i.amount }
  end

end
