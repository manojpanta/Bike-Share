class TripsController < ApplicationController

  def index
    @trips = Trip.paginate(page: params[:page])
  end

  def show
    @trip = Trip.find(params[:id])
  end

  def dashboard
    @average = Trip.average(:duration)
    @longest = Trip.where(duration: Trip.maximum(:duration)).first.id
    @shortest = Trip.where(duration: Trip.minimum(:duration)).first.id
    @most_starts = Station.find(Trip.select('COUNT(id) AS trip_count, start_station_id').group(:start_station_id).order('trip_count DESC').first.start_station_id)
    @fewest_starts = Station.find(Trip.select('COUNT(id) AS trip_count, end_station_id').group(:end_station_id).order('trip_count DESC').first.end_station_id)
    # binding.pry

  end
end
