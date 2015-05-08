class OrdersController < ApplicationController

  def index
    @orders = Order.page(params[:page]).per(10)
  end

  def new
    @order = Order.new
  end
  def show
    @order = Order.all
  end

  def create
    @order = Order.new(order_params)
    @order.add_line_items(current_cart)

    if @order.save
      current_cart.destroy
      redirect_to '/products'
    else
      render :action => :new
    end
  end

  protected

  def order_params
    params.require(:order).permit(:name, :email, :phone, :address)
  end

end
