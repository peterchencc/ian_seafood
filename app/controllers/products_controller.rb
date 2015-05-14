class ProductsController < ApplicationController

  before_action :authenticate_user!
  before_action :check_admin

  def index
    @products = Product.all
    @products = @products.only_published(current_user)
    @products = Product.page(params[:page]).per(7)
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true).page(params[:page]).per(7)
    @products = @products.includes(:packets) 
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
  @product = Product.new( product_params )

    if @product.save

      flash[:notice] = "新增成功"

      redirect_to products_path
    else
      load_products
      render :action => :index
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

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
    Product.first.destroy

    flash[:alert] = "刪除成功"
    redirect_to products_url
  end

  protected

  def product_params
    params.require(:product).permit(:name, :image, :description, :price, :status,:in_stock_qty)
  end

end
