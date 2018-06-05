require 'rails_helper'

describe Trip, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:start_date)}
    it {should validate_presence_of(:end_date)}
    it {should validate_presence_of(:bike_id)}
    it {should validate_presence_of(:subscription_type)}
  end
  describe 'Relationships' do
    it {should belong_to :start_station}
    it {should belong_to :end_station}
  end

  describe "class methods" do
    it "#rides_by_month"
      date1 = Date.new(2013, 1, 1)
      date2 = Date.new(2013, 2, 1)
      date3 = Date.new(2013, 3, 1)
      date4 = Date.new(2013, 4, 1)
      station = Station.create(name: 'Foo', dock_count: 5, city: 'Denver', installation_date: Time.zone.now)
      5.times do
        Trip.create(start_date: date1, start_station: station, end_date: date1, end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )
      end
      4.times do
        Trip.create(start_date: date2, start_station: station, end_date: date2, end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )
      end
      3.times do
        Trip.create(start_date: date3, start_station: station, end_date: date3, end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )
      end
      2.times do 
        Trip.create(start_date: date4, start_station: station, end_date: date4, end_station: station, bike_id: 4, subscription_type: 'Member', zip_code: 80202 )
      end

      expected = [ date1: 5, date2: 4, date3: 3, date4: 2]

      expect(Trip.rides_by_month).to eq(expected)
  end
  
end
