require 'rails_helper'

describe "An admin" do
  context "visits the admin new trip page" do
    it "and sees a form to add a new trip" do
    admin = User.create(name: 'bob', email: 'bob@bob.bob', password: '1234', address: '123 Elm St', role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_trip_path

    fill_in :start_date,	with: Time.now
    fill_in :start_station,	with: :start_station.name
    end
  end
end
