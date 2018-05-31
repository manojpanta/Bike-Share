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
      @order = @user.orders
      if current_admin?
        @total_ordered = Order.total_ordered
        @total_paid = Order.total_paid
        @total_cancelled = Order.total_paid
        @all_orders = Order.all
      end
    else
      render file: '/public/404'
    end
  end

  def edit
    if current_user && current_user.id == params[:id].to_i
      @user = current_user
    else
      render file: 'public/404'
    end
  end

  def update
    user = current_user
    user.update(user_params)
    if user.save
      flash[:notice] = "Information updated #{user.name}"
      session[:user_id] = user.id
      redirect_to '/dashboard'
    else
      flash[:error] = "User update failed"
      redirect_to '/dashboard'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :address)
  end
end
