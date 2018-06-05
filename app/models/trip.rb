class Trip < ApplicationRecord
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :bike_id, presence: true
  validates :subscription_type, presence: true

  belongs_to :start_station, class_name: 'Station'

  belongs_to :end_station, class_name: 'Station'

  def self.subscriptions
    Trip.select('COUNT(id) AS sub_count, subscription_type').group(:subscription_type).order('sub_count DESC')
  end

  def self.bikes
    Trip.select('COUNT(id) AS bike_count, bike_id').group(:bike_id).order('bike_count DESC')
  end

  def self.most_ends
    Trip.select('COUNT(id) AS trip_count, end_station_id').group(:end_station_id).order('trip_count DESC').first.end_station
  end

  def self.most_starts
    Trip.select('COUNT(id) AS trip_count, start_station_id').group(:start_station_id).order('trip_count DESC').first.start_station
  end

  def self.shortest
    Trip.where(duration: Trip.minimum(:duration)).first.id
  end

  def self.longest
    Trip.where(duration: Trip.maximum(:duration)).first.id
  end

  def self.dates
    Trip.select('COUNT(id) AS date_count, start_date').group(:start_date).order('date_count DESC')
  end

  def self.months
    Trip.group("date_trunc('month', start_date)").count
  end

  def self.years
    Trip.group("date_trunc('year', start_date)").count
  end
end
