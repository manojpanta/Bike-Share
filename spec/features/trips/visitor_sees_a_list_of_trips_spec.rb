require 'rails_helper'

describe "A visitor" do
  context "visits the trips index page" do
    it "and should see the start date, start station, end date, end station, bike id, subscription type, zip code" do
      station = Station.create(name: 'Foo', dock_count: 5, city: 'Denver', installation_date: Time.now)
      trip1 = Trip.create(start_date: Time.now, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )
      trip2 = Trip.create(start_date: Time.now, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )

      visit trips_path

      expect(page).to have_content(trip1.start_date)
      expect(page).to have_content(trip1.start_station.name)
      expect(page).to have_content(trip1.end_date)
      expect(page).to have_content(trip1.end_station.name)
      expect(page).to have_content(trip1.bike_id)
      expect(page).to have_content(trip1.subscription_type)
      expect(page).to have_content(trip1.zip_code)
      expect(page).to have_content(trip2.start_date)
      expect(page).to have_content(trip2.start_station.name)
      expect(page).to have_content(trip2.end_date)
      expect(page).to have_content(trip2.end_station.name)
      expect(page).to have_content(trip2.bike_id)
      expect(page).to have_content(trip2.subscription_type)
      expect(page).to have_content(trip2.zip_code)

    end

    it "and should see the top 30 trips with duration" do
      station = Station.create(name: 'Foo', dock_count: 5, city: 'Denver', installation_date: Time.now)
      29.times do
        Trip.create(start_date: Time.now, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )
      end
        Trip.create(start_date: Time.now, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 12345, subscription_type: 'Member', zip_code: 80202 )
        Trip.create(start_date: Time.now, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 23456, subscription_type: 'Member', zip_code: 80202 )

      visit trips_path

      expect(page).to have_content(12345)
      expect(page).to_not have_content(23456)
    end
  end
end