class ApplicationController < ActionController::Base

  helper_method :current_user, :current_admin?

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
