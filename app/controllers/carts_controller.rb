class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    accessory = Accessory.find(params[:accessory_id])
    session[:cart] ||= Hash.new(0)
    session[:cart][accessory.id.to_s] = session[:cart][accessory.id.to_s] + 1
    flash[:notice] = "You now have #{pluralize(session[:cart][accessory.id.to_s], accessory.title)} in your cart."
    redirect_to '/bike-shop'
  end


end
