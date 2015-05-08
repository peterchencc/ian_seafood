class OrdersController < ApplicationController

  before_action :authenticate_user!
  
  def index
    @orders = Order.page(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
  end

end
