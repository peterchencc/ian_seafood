class ApiV1::ProductsController < ApiController

  def index
    @products = Product.where(:status => "published").includes(:packets => :pictures).all
  end

end
