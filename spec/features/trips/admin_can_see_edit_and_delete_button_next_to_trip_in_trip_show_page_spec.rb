require 'rails_helper'

describe "A visitor" do
  context " as admin visits the trip show page" do
    it "and can delete or edit trip" do
      admin = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St', role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      station = Station.create(name: 'Foo', dock_count: 5, city: 'Denver', installation_date: Time.now)
      trip = Trip.create(start_date: Time.now, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )

      visit trip_path(trip)

      expect(page).to have_link('Edit')
      expect(page).to have_link('Delete')
    end
    it "and  edit trip" do
      admin = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St', role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      station = Station.create(name: 'Foo', dock_count: 5, city: 'Denver', installation_date: Time.now)
      trip = Trip.create(start_date: Time.now, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )

      visit trip_path(trip)

      click_on 'Edit'


      expect(current_path).to eq(edit_admin_trip_path(trip))
    end
    it "and  delete trip" do
      admin = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St', role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      station = Station.create(name: 'Foo', dock_count: 5, city: 'Denver', installation_date: Time.now)
      trip = Trip.create(start_date: Time.now, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )

      visit trip_path(trip)

      click_on 'Delete'

      expect(current_path).to eq(trips_path)
      expect(page).to_not have_content(trip.start_date)
      expect(page).to_not have_content(trip.start_station)
      expect(page).to_not have_content(trip.end_date)
      expect(page).to_not have_content(trip.end_station)
      expect(page).to_not have_content(trip.subscription_type)
      expect(page).to_not have_content(trip.bike_id)
      expect(page).to_not have_content(trip.zip_code)
    end
  end
end
