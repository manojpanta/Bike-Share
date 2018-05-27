require 'rails_helper'

describe "A visitor" do
  context "visits the stations home page" do
    it "and sees the attributes for that station" do
      station = Station.create(name:'Foo', dock_count: 5, city: 'Denver', installation_date: Time.now)

      visit station_path(station)

      expect(page).to have_content(station.name)
      expect(page).to have_content(station.dock_count)
      expect(page).to have_content(station.city)
      expect(page).to have_content(station.installation_date)
      expect(current_path).to eq("/stations/#{station.name}")
    end
  end
end
