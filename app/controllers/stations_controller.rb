class StationsController < ApplicationController

  def index
    @stations = Station.all
  end
  
  def show
    @station = Station.find_by_param(params[:id])
  end
  
end