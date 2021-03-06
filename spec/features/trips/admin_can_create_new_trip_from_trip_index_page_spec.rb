require 'rails_helper'

describe "An admin" do
  context "visits the trips index page" do
    it "and can see buttons to create new trip " do
      admin = User.create!(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St', role: 1)
      station = Station.create!(name: 'Foo', dock_count: 5, city: 'Denver', installation_date: Time.now)
      trip1 = Trip.create!(start_date: Time.now, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )
      trip2 = Trip.create!(start_date: Time.now, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit trips_path

      click_on 'Create New Trip'

      expect(current_path).to eq(new_admin_trip_path)
    end
  end
end
