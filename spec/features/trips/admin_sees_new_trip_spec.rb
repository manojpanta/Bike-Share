require 'rails_helper'

describe "An admin" do
  context "visits the admin new trip page" do
    it "and sees a form to add a new trip" do
    admin = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St', role: 1)
    station = Station.create(name: 'Foo', dock_count: 5, city: 'Denver', installation_date: Time.now)
    trip = Trip.create(duration: 100, start_date: Time.now, start_station: station, end_date: (Time.now + 1), end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_trip_path

    save_and_open_page
    fill_in :duration,	with: trip.duration
    fill_in :start_date,	with: trip.start_date
    fill_in :start_station,	with: station.name
    fill_in :end_date,	with: trip.end_date
    fill_in :end_station,	with: station.name
    fill_in :bike_id,	with: trip.bike_id
    fill_in :subscription_type,	with: trip.subscription_type
    fill_in :zip_code,	with: trip.zip_code

    click_on 'Create Trip'
    expect(current_page).to eq(admin_trip)
    expect(current_page).to have_content(trip.duration)
    expect(current_page).to have_content(trip.start_date)
    expect(current_page).to have_content(station.name)
    expect(current_page).to have_content(trip.end_date)
    expect(current_page).to have_content(station.name)
    expect(current_page).to have_content(trip.bike_id)
    expect(current_page).to have_content(trip.subscription_type)
    expect(current_page).to have_content(trip.zip_code)
    end
  end
end
