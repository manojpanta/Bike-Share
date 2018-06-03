class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if current_admin?
        flash[:notice] = "Logged in as  Admin User: #{user.name}"
        redirect_to '/admin/dashboard'
      else
        flash[:notice] = "Logged in as #{user.name}"
        redirect_to '/dashboard'
      end
    else
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    session[:cart] = nil
    redirect_to root_path
  end
end
