class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception

  helper_method :current_cart

  protected

  def check_admin
    unless current_user.admin?
      flash[:alert] = "非管理者身份不給進!"
      redirect_to root_path
      return
    end
  end

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

  def after_sign_in_path_for(resource)
    products_path
  end
end
