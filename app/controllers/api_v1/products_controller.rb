class ApiV1::ProductsController < ApiController

  def index
    @products = Product.page( params[:page] )
  end

end
