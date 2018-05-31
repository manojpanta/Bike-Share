class Station < ApplicationRecord
  validates_uniqueness_of :name, presence: true
  validates :dock_count, presence: true
  validates :city, presence: true
  validates :installation_date, presence: true

  has_many :trips_started, class_name: 'Trip', foreign_key: 'start_station_id'
  has_many :trips_ended, class_name: 'Trip', foreign_key: 'end_station_id'

  def to_param
    name
  end

  def self.find_by_param(input)
    find_by_name(input)
  end

  def self.total_station_count
    all.count
  end

  def self.avg_bikes_count
    average(:dock_count).to_i
  end

  def self.most_bikes_in_one_station
    maximum(:dock_count)
  end

  def self.station_with_most_bikes
    where(dock_count: maximum(:dock_count))
  end

  def self.station_with_fewest_bikes
    where(dock_count: minimum(:dock_count))
  end

  def self.fewest_bikes_in_one_station
    minimum(:dock_count)
  end

  def self.most_recently_installed
    find_by(installation_date: maximum(:installation_date))
  end

  def self.oldest_station
    find_by(installation_date: minimum(:installation_date))
  end

  def started_here
    trips_started.count
  end
  
  def ended_here
    trips_ended.count
  end
  
  def frequent_destination
      destination = trips_ended.group(:end_station_id)
                              .order('count_all DESC')
                              .count
      if destination.empty?
        "Unknown"
      else
        Station.find(destination.first[0]).name
      end
  end

  def frequent_origination
      origination = trips_started.group(:start_station_id)
                              .order('count_all DESC')
                              .count
      if origination.empty?
        "Unknown"
      else
        Station.find(origination.first[0]).name
      end
  end
  
end
