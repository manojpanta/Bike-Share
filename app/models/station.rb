class Station < ApplicationRecord
  validates_uniqueness_of :name, presence: true
  validates :dock_count, presence: true
  validates :city, presence: true
  validates :installation_date, presence: true

  has_many :trips_started, class_name: 'Trip', foreign_key: 'start_station_id'
  has_many :trips_ended, class_name: 'Trip', foreign_key: 'end_station_id'
  
end
