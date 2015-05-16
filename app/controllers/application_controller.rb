class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :authenticate_user!
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

  def after_sign_in_path_for(resource)
    products_path
  end
end
