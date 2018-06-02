class AccessoriesController < ApplicationController
  def index
    @accessories = Accessory.all
    @cart = Cart.new(session[:cart])
  end

  def show
    @accessory = Accessory.find(params[:id])
  end
end
