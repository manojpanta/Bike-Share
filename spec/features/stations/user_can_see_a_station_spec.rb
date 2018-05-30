require 'rails_helper'

describe "A registered user" do
  context "visits a station show page" do
    it "and sees the number of rides started at this station" do
      user = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St')
      station = Station.create(name:'Foo', dock_count: 5, city: 'Denver', installation_date: Time.now)
      Trip.create(duration: 100, start_date: Time.now, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )

      visit station_path(station)

      expect(page).to have_content("Number of rides started from here: 1")

      Trip.create(duration: 90, start_date: (Time.now + 2), start_station: station, end_date: (Time.now + 3), end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )

      visit station_path(station)

      expect(page).to have_content("Number of rides started from here: 2")
    end

    it "and sees the number of rides ended at this station" do
      user = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St')
      station = Station.create(name:'Foo', dock_count: 5, city: 'Denver', installation_date: Time.now)
      Trip.create(duration: 100, start_date: Time.now, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )

      visit station_path(station)

      expect(page).to have_content("Number of rides ended from here: 1")

      Trip.create(duration: 90, start_date: (Time.now + 2), start_station: station, end_date: (Time.now + 3), end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )

      visit station_path(station)

      expect(page).to have_content("Number of rides ended from here: 2")
    end
  end
end



# As a registered user,
# When I visit a station show,
# In addition to the user story above,
# I see the Number of rides started at this station,
# I see the Number of rides ended at this station,
# I see the Most frequent destination station (for rides that began at this station),
# I see the Most frequent origination station (for rides that ended at this station),
# I see the Date with the highest number of trips started at this station,
# I see the Most frequent zip code for users starting trips at this station,
# I see the Bike ID most frequently starting a trip at this station.