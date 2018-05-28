require 'rails_helper'

describe "A visitor" do
  context "visits the trip show page" do
    it "and sees all attributes of a trip" do
      station = Station.create(name: 'Foo', dock_count: 5, city: 'Denver', installation_date: Time.now)
      trip = Trip.create(start_date: Time.now, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )

      visit trip_show_path

      expect(page).to have_content(trip.start_date)
      expect(page).to have_content(trip.start_station.name)
      expect(page).to have_content(trip.end_date)
      expect(page).to have_content(trip.end_station.name)
      expect(page).to have_content(trip.bike_id)
      expect(page).to have_content(trip.subscription_type)
      expect(page).to have_content(trip.zip_code)
    end
  end
end
