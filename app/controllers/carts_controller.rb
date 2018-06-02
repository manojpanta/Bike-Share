class CartsController < ApplicationController

  def create
    accessory = Accessory.find(params[:accessory_id])
    flash[:notice] = "You now have 1 #{accessory.title} in your cart."
    redirect_to '/bike-shop'
  end


end
