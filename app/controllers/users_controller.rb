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

  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :address)
  end
end
