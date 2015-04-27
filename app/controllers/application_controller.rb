class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_cart

  protected

  def current_cart
    @cart || set_cart
  end

  def set_cart
    if session[:cart_id]
      @cart = Cart.find_by_id( session[:cart_id] )
    end
    @cart ||= Cart.create

    session[:cart_id] = @cart.id
    @cart
  end

end
