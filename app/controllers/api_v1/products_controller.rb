class ApiV1::ProductsController < ApiController

  def index
    @products = Product.all
  end

end
