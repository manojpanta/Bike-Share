class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    if current_user && @order.user == current_user

    elsif current_admin?

    else
      render file: '/public/404'
    end
  end
end
