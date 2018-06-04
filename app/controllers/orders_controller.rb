class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    if current_user && @order.user == current_user

    elsif current_admin?

    else
      render file: '/public/404'
    end
  end

  def create
    @user = current_user
    @orders = @user.orders.create
    @items = []
    render file: '/public/404' if !current_user
    return render file: '/public/404' if params[:cart_items] == nil
    until params[:cart_items].empty?
      @items << params[:cart_items].slice!(0..1)
    end
    @items.each do |i, quantity|
      i = Accessory.find(i.first.to_i)
      quantity = quantity.first.to_i
      @orders.accessory_orders.create(accessory: i, quantity: quantity)
    end
    flash[:notice] = "Successfully submitted your order totaling $ #{@orders.cost}"
    session[:cart] = nil
    redirect_to dashboard_path(current_user)
  end
end
