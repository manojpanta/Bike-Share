class Admin::StationsController < Admin::BaseController
  def new
    @station = Station.new
  end

  def create
    @station = Station.new(station_params)
    if @station.save
      flash[:notice] = "#{@station.name} station created!"
      redirect_to station_path(@station)
    else
      render :new
    end
  end

  def edit
    @station = Station.find_by(:name => 'Foo')
  end

  def update
    @station = Station.find_by(:name => 'Foo')
    @station.update(station_params)
    flash[:notice] = "#{@station.name} station updated!"
    redirect_to station_path(@station)
  end

  private
  def station_params
    params.require(:station).permit(:name, :dock_count, :city, :installation_date)
  end

end
