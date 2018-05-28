class TripsController < ApplicationController

  def index
    @trips = Trip.paginate(page: params[:page])
  end
  
end