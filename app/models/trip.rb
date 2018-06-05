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
end
