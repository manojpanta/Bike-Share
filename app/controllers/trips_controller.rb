class TripsController < ApplicationController

  def index
    @trips = Trip.paginate(page: params[:page])
  end

  def show
    @trip = Trip.find(params[:id])
  end

  def dashboard
    render file: '/public/404' if !current_user
    @average = Trip.average(:duration)
    @longest = Trip.where(duration: Trip.maximum(:duration)).first.id
    @shortest = Trip.shortest
    # Trip.where(duration: Trip.minimum(:duration)).first.id
    @most_starts = Trip.most_starts
    @most_ends = Trip.most_ends

    bikes = Trip.bikes
    @most_ridden_bike = bikes.first.bike_id
    @most_bike_rides = bikes.first.bike_count
    @least_ridden_bike = bikes.last.bike_id
    @fewest_bike_rides = bikes.last.bike_count

    subscriptions = Trip.subscriptions
    total_count = Trip.count
    @subscriber_count = subscriptions.where(subscription_type: 'Subscriber').first.sub_count
    @subscriber_percent = (@subscriber_count * 100) / total_count
    @customer_count = subscriptions.where(subscription_type: 'Customer').first.sub_count
    @customer_percent = (@customer_count * 100) / total_count

    dates = Trip.select('COUNT(id) AS date_count, start_date').group(:start_date).order('date_count DESC')
    @max_date = dates.first
    @min_date = dates.last

    # Trip.group("date_trunc('month', start_date)").count
    @months = Trip.group("date_trunc('month', start_date)").count


    # binding.pry
    # .select("COUNT(id) AS year_count, DATEPART(YEAR, start_date) AS year_of").group('DATEPART(YEAR, start_date)')
  end
end
