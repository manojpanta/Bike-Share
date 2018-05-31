# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Station.destroy_all
# Trip.destroy_all
# # User.destroy_all

TITLES = ['wranch', 'screw driver', 'Jumper Cables', 'socket set']
IMAGES = ['https://cimg2.ibsrv.net/cimg/www.doityourself.com/660x300_100-1/514/Tools-199514.jpg', 'https://www.3wayplumbing.com/Portals/0/EasyGalleryImages/1/73/tools.jpg', 'https://cdn.everydaycarry.com/uploads/17-12-04/15a257f8f0ad64.jpg']
PRICES = [12, 34, 45, 56, 67, 67, 92]
DESCRIPTIONS = ['This my tool', 'This tool is necessory', 'This tool is must have', 'Hepls you fix your oil change', 'This is the best offer you will see today', 'This is not really the product we think is useful for household usage', 'This is not a goo tool we have to be honest with you all.']
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
  Trip.create(
  id:             trip[:id],
  duration:             trip[:duration],
  start_date:           DateTime.strptime(trip[:start_date], '%m/%d/%y %H:%M'),
  end_date:            DateTime.strptime(trip[:end_date], '%m/%d/%y %H:%M'),
  bike_id:     trip[:bike_id],
  subscription_type:   trip[:subscription_type],
  zip_code:    trip[:zip_code],
  start_station_id:    trip[:start_station_id],
  end_station_id:    trip[:end_station_id])
end

50.times do
  retired = false
  if rand > 0.8
    retired = true
  end
  Accessory.create!(title: TITLES.sample, image: IMAGES.sample, price: PRICES.sample, description: DESCRIPTIONS.sample, is_retired?: retired)
end

m = User.create(name: 'manoj', email: 'manoj', password: 'manoj', address: 'manoj', role: 1)
5.times do
  o = m.orders.create(status: rand(4))
  2.times do
    item = Accessory.all.sample
    o.accessory_orders.create(accessory: item, quantity: (rand(3) + 1))
  end
end
s = User.create(name: 'steve', email: 'bob@bob.bob', password: '1234', address: 'manoj', role: 1)
5.times do
  o = s.orders.create(status: rand(4))
  3.times do
    item = Accessory.all.sample
    o.accessory_orders.create(accessory: item, quantity: (rand(3) + 1))
  end
end
u = User.create(name: 'user', email: 'user@bob.bob', password: '1234', address: 'manoj', role: 0)
5.times do
  o = u.orders.create(status: rand(4))
  2.times do
    item = Accessory.all.sample
    o.accessory_orders.create(accessory: item, quantity: (rand(3) + 1))
  end
end
