class Trip < ApplicationRecord
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :bike_id, presence: true
  validates :subscription_type, presence: true

  belongs_to :start_station, class_name: 'Station'
  belongs_to :end_station, class_name: 'Station'
end
