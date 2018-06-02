require 'rails_helper'

describe "A user" do
  it "visits the trips dashboard" do
    user = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    station1 = Station.create(name: 'Foo', dock_count: 5, city: 'Denver', installation_date: Time.now.gmtime)
    station2 = Station.create(name: 'Bar', dock_count: 10, city: 'Denver', installation_date: Time.now.gmtime)
    date1 = DateTime.strptime('8/29/13 16:18', '%m/%d/%y %H:%M')
    date2 = DateTime.strptime('8/29/14 16:18', '%m/%d/%y %H:%M')
    trip1 = Trip.create!(duration: 5, start_date: date1, start_station: station1, end_date: (Time.now + 5).gmtime, end_station: station2, bike_id: 3, subscription_type: 'Subscriber', zip_code: 80202 )
    trip2 = Trip.create!(duration: 10, start_date: date1, start_station: station1, end_date: (Time.now + 10).gmtime, end_station: station2, bike_id: 4, subscription_type: 'Customer', zip_code: 80202 )
    trip3 = Trip.create!(duration: 20, start_date: date2, start_station: station1, end_date: (Time.now + 20).gmtime, end_station: station2, bike_id: 4, subscription_type: 'Subscriber', zip_code: 80202 )

    visit 'trips-dashboard'

    average = (trip1.duration + trip2.duration + trip3.duration) / 3
    expect(page).to have_content("Average Duration:\n#{average} seconds")
    expect(page).to have_content("Longest Ride:\n#{trip3.id}")
    expect(page).to have_content("Shortest Ride:\n#{trip1.id}")
    expect(page).to have_content("Station With Most Rides Started:\n#{station1.name}")
    expect(page).to have_content("Station With Most Rides Ended:\n#{station2.name}")
    expect(page).to have_content("Most Ridden Bike:\n#{trip2.bike_id}, 2 rides")
    expect(page).to have_content("Least Ridden Bike:\n#{trip1.bike_id}, 1 rides")
    expect(page).to have_content("Subscribers:\n2, %66")
    expect(page).to have_content("Customers:\n1, %33")
    expect(page).to have_content("Date With Most Rides:\n#{date1.to_s[0..9]}")
    expect(page).to have_content("Date With Fewest Rides:\n#{date2.to_s[0..9]}")
  end
  it "shows trips by month" do
    user = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    station1 = Station.create(name: 'Foo', dock_count: 5, city: 'Denver', installation_date: Time.now.gmtime)
    station2 = Station.create(name: 'Bar', dock_count: 10, city: 'Denver', installation_date: Time.now.gmtime)
    date1 = DateTime.strptime('8/29/13 16:18', '%m/%d/%y %H:%M')
    date2 = DateTime.strptime('7/29/14 16:18', '%m/%d/%y %H:%M')
    date3 = DateTime.strptime('6/29/14 16:18', '%m/%d/%y %H:%M')
    date4 = DateTime.strptime('6/28/14 16:18', '%m/%d/%y %H:%M')
    trip1 = Trip.create!(duration: 5, start_date: date1, start_station: station1, end_date: (Time.now + 5).gmtime, end_station: station2, bike_id: 3, subscription_type: 'Subscriber', zip_code: 80202 )
    trip2 = Trip.create!(duration: 10, start_date: date2, start_station: station1, end_date: (Time.now + 10).gmtime, end_station: station2, bike_id: 4, subscription_type: 'Customer', zip_code: 80202 )
    trip3 = Trip.create!(duration: 20, start_date: date3, start_station: station1, end_date: (Time.now + 20).gmtime, end_station: station2, bike_id: 4, subscription_type: 'Subscriber', zip_code: 80202 )
    trip4 = Trip.create!(duration: 20, start_date: date4, start_station: station1, end_date: (Time.now + 20).gmtime, end_station: station2, bike_id: 4, subscription_type: 'Subscriber', zip_code: 80202 )

    visit 'trips-dashboard'
    # save_and_open_page
    expect(page).to have_content("June, 2014:\n2")
    expect(page).to have_content("August, 2013:\n1")
    # expect(page).to have_content("June\t2\t1\t1")
  end
end
