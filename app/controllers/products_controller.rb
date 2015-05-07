class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin
  def index
    @products = Product.page(params[:page]).per(7)
  end

  def show
    @product = Product.find(params[:id])
  end
  
  protected

  def check_admin
    unless current_user.admin?
      flash[:alert] = "Nooooooooooo!"
      redirect_to root_path
      return
    end
  end
end
