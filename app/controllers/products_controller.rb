class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin
  def index
    @products = Product.page(params[:page]).per(7)
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
  end

  def update
    if @product.update( product_params )

      flash[:notice] = "編輯成功"

      redirect_to products_path
    else
      render :action => :edit
    end
  end

  def bulk_update
  products = params[:ids].map{ |x| Product.find(x) }

  products.each do |x|
    if params["btn-delete"]
      x.destroy
    elsif params["btn-publish"]
      x.update( :status => "published" )
    end
  end

  redirect_to products_url
end

def bulk_delete
  #Event.destroy_all
  Product.first.destroy

  flash[:alert] = "砍了!"
  redirect_to products_url
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
