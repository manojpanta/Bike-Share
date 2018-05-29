class Admin::TripsController < Admin::BaseController
  def edit
    @trip = Trip.find(params[:id])
  end

  def new
    @trip = Trip.new
  end
  

  def destroy
    @trip = Trip.find(params[:id])
    @trip.destroy
    flash[:notice]= "Trip has been Deleted!"
    redirect_to trips_path
  end

  def create
    @trip = Trip.new(trip_params)
    if @trip.save
      flash[:notice] = "Trip has been created!"
      redirect_to trip_path(@trip)
    else
      render :new
    end
  end

  private

  def trip_params
    params.require(:trip).permit(:duration, :start_date, :end_date, :bike_id, :subscription_type, :zip_code, :created_at, :updated_at, :start_station_id, :end_station_id)
  end

end
