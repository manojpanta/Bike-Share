class StationsController < ApplicationController

  def index
    @stations = Station.all
  end

  def show
    @station = Station.find_by_param(params[:id])
  end

  def dashboard
    @total_station_count = Station.total_station_count
    @avg_bikes_count = Station.avg_bikes_count
    @most_bikes_in_one_station = Station.most_bikes_in_one_station
    @station_with_most_bikes = Station.station_with_most_bikes.first.name
  end
end
