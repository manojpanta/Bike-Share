class Admin::OrdersController < Admin::BaseController

  def update
    @order = Order.find(params[:id])
    @order.update(status: params[:status])
    redirect_to 'admin/dashboard'
  end
end
