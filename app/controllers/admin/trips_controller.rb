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
end
