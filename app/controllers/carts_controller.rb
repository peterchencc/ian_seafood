class CartsController < ApplicationController

  def create
    product = Product.find(params[:product_id])
    line_item = current_cart.add_line_item(product)
    line_item.save!

    redirect_to :back
  end

end
