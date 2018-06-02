class Admin::OrdersController < Admin::BaseController

  def update
    @order = Order.find(params[:id])
    @order.update(status: params[:status])

    redirect_back(fallback_location: admin_dashboard_path)
  end
end
