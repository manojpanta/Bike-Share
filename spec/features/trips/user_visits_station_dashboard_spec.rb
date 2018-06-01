require 'rails_helper'

describe "A user" do
  it "visits the trips dashboard" do
    station1 = Station.create(name: 'Foo', dock_count: 5, city: 'Denver', installation_date: Time.now.gmtime)
    station2 = Station.create(name: 'Bar', dock_count: 10, city: 'Denver', installation_date: Time.now.gmtime)

    trip1 = Trip.create!(duration: 5, start_date: Time.now.gmtime, start_station: station1, end_date: (Time.now + 5).gmtime, end_station: station2, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )
    trip2 = Trip.create!(duration: 10, start_date: Time.now.gmtime, start_station: station1, end_date: (Time.now + 10).gmtime, end_station: station2, bike_id: 4, subscription_type: 'Customer', zip_code: 80202 )
    trip3 = Trip.create!(duration: 20, start_date: Time.now.gmtime, start_station: station1, end_date: (Time.now + 20).gmtime, end_station: station2, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )

    visit 'trips-dashboard'

    average = (trip1.duration + trip2.duration + trip3.duration) / 3
    expect(page).to have_content("Average Duration:\n#{average} seconds")
    expect(page).to have_content("Longest Ride:\n#{trip3.id}")
    expect(page).to have_content("Shortest Ride:\n#{trip1.id}")
    expect(page).to have_content("Station With Most Rides Started:\n#{station1.name}")
    expect(page).to have_content("Station With Most Rides Ended:\n#{station2.name}")

  end
end
