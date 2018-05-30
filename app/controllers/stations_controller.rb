class StationsController < ApplicationController

  def index
    @stations = Station.all
  end

  def show
    @station = Station.find_by_param(params[:id])
    @started_here = @station.started_here
    @ended_here = @station.ended_here
  end

  def dashboard
    @total_station_count = Station.total_station_count
    @avg_bikes_count = Station.avg_bikes_count
    @most_bikes_in_one_station = Station.most_bikes_in_one_station
    @fewest_bikes_in_one_station = Station.fewest_bikes_in_one_station
    @station_with_most_bikes = Station.station_with_most_bikes
    @station_with_fewest_bikes = Station.station_with_fewest_bikes
    @recent_station = Station.most_recently_installed.name
    @oldest_station = Station.oldest_station.name
  end
end
