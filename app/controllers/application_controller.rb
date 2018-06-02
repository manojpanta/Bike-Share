class ApplicationController < ActionController::Base

  helper_method :current_user, :current_admin?
  before_action :set_cart

  def set_cart
    if !session[:cart]
      session[:cart] = Hash.new
    end
    @cart = Cart.new(session[:cart])
  end

  def current_user
    if session[:user_id]
      id = session[:user_id]
      if User.exists?(id)
        @current_user ||= User.find(id)
      end
    end
  end

  def current_admin?
    current_user && current_user.admin?
  end
end
