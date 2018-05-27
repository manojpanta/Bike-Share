class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      flash[:notice] = "Logged in as #{user.name}"
      session[:user_id] = user.id
      redirect_to '/dashboard'
    else
      flash[:error] = "User creation failed"
      redirect_to new_user_path
    end
  end

  def show
    if current_user
      @user = current_user
    else
      render file: '/public/404'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :address)
  end
end
