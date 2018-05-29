# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Station.destroy_all
Trip.destroy_all
require 'csv'
require File.expand_path('../config/environment', __dir__)



stations = CSV.open('./data/station.csv',
                    headers: true,
                    header_converters: :symbol)
stations.each do |station|
  Station.create(
  id:             station[:id],
  name:           station[:name],
  dock_count:     station[:dock_count],
  city:           station[:city],
  installation_date:    DateTime.strptime(station[:installation_date], '%m/%d/%Y')
  )
end
trips = CSV.open('./data/trip.csv',
                    headers: true,
                    header_converters: :symbol)
trips.each do |trip|
  Trip.create!(
  id:             trip[:id],
  duration:             trip[:duration],
  start_date:           DateTime.strptime(trip[:start_date], '%m/%d/%Y'),
  end_date:            DateTime.strptime(trip[:end_date], '%m/%d/%Y'),
  bike_id:     trip[:bike_id],
  subscription_type:   trip[:subscription_type],
  zip_code:    trip[:zip_code],
  start_station_id:    trip[:start_station_id],
  end_station_id:    trip[:end_station_id])
end
