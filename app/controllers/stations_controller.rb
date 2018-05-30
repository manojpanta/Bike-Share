class StationsController < ApplicationController

  def index
    @stations = Station.all
  end

  def show
    @station = Station.find_by_param(params[:id])
  end

  def dashboard
    @total_station_count = Station.total_station_count
  end

end
