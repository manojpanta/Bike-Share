require 'rails_helper'
describe Station, type: :model do
  describe 'validations' do
    it {should validate_uniqueness_of(:name)}
    it {should validate_presence_of(:dock_count)}
    it {should validate_presence_of(:city)}
    it {should validate_presence_of(:installation_date)}
  end
  describe 'Relationships' do
    it {should have_many :trips_started}
    it {should have_many :trips_ended}
  end

  describe 'class method' do
    it 'calculates stations count' do
      name = 'Foo'
      name1 = 'Foo1'
      dock_count = 5
      city = 'denver'
      installation_date = Time.now
      Station.create(name: name, dock_count: dock_count, city: city, installation_date: installation_date)
      Station.create(name: name1, dock_count: dock_count, city: city, installation_date: installation_date)

      expect(Station.total_station_count).to eq(2)
    end
  end

  describe 'class method' do
    it 'calculates average bikes available' do
      name = 'Foo'
      name1 = 'Foo1'
      name2 = 'Foo2'
      dock_count = 5
      dock_count1 = 10
      dock_count2 = 15
      city = 'denver'
      installation_date = Time.now
      s1 = Station.create(name: name, dock_count: dock_count, city: city, installation_date: installation_date)
      s2 = Station.create(name: name1, dock_count: dock_count1, city: city, installation_date: installation_date)
      s3 = Station.create(name: name2, dock_count: dock_count2, city: city, installation_date: installation_date)

      avg_bike_count = (s1.dock_count + s2.dock_count + s3.dock_count) / 3

      expect(Station.avg_bikes_count).to eq(avg_bike_count)
    end
  end
  describe 'class method' do
    it 'calculates most bikes available in one station' do
      name = 'Foo'
      name1 = 'Foo1'
      name2 = 'Foo2'
      dock_count = 5
      dock_count1 = 10
      dock_count2 = 15
      city = 'denver'
      installation_date = Time.now

      Station.create(name: name, dock_count: dock_count, city: city, installation_date: installation_date)
      Station.create(name: name1, dock_count: dock_count1, city: city, installation_date: installation_date)
      Station.create(name: name2, dock_count: dock_count2, city: city, installation_date: installation_date)

      most_bike_available_in_one_station = 15

      expect(Station.most_bikes_in_one_station).to eq(most_bike_available_in_one_station)
    end
  end
  describe 'class method' do
    it 'it shows station with most bikes count' do
      name = 'Foo'
      name1 = 'Foo1'
      name2 = 'Mnaoj'
      dock_count = 5
      dock_count1 = 10
      dock_count2 = 15
      city = 'denver'
      installation_date = Time.now

      s1 = Station.create(name: name, dock_count: dock_count, city: city, installation_date: installation_date)
      s2 = Station.create(name: name1, dock_count: dock_count1, city: city, installation_date: installation_date)
      s3 = Station.create(name: name2, dock_count: dock_count2, city: city, installation_date: installation_date)

      top_station = s3.name

      expect(Station.station_with_most_bikes.name).to eq(top_station)
    end
  end

  describe 'class method' do
    it 'calculates  fewest bikes available in one station' do
      name = 'Foo'
      name1 = 'Foo1'
      name2 = 'Foo2'
      dock_count = 5
      dock_count1 = 10
      dock_count2 = 15
      city = 'denver'
      installation_date = Time.now

      Station.create(name: name, dock_count: dock_count, city: city, installation_date: installation_date)
      Station.create(name: name1, dock_count: dock_count1, city: city, installation_date: installation_date)
      Station.create(name: name2, dock_count: dock_count2, city: city, installation_date: installation_date)

      fewest_bike_available_in_one_station = 5

      expect(Station.fewest_bikes_in_one_station).to eq(fewest_bike_available_in_one_station)
    end
  end

  describe 'class method' do
    it 'it shows station with fewest bikes count' do
      name = 'Foo'
      name1 = 'Foo1'
      name2 = 'Mnaoj'
      dock_count = 5
      dock_count1 = 10
      dock_count2 = 15
      city = 'denver'
      installation_date = Time.now

      s1 = Station.create(name: name, dock_count: dock_count, city: city, installation_date: installation_date)
      s2 = Station.create(name: name1, dock_count: dock_count1, city: city, installation_date: installation_date)
      s3 = Station.create(name: name2, dock_count: dock_count2, city: city, installation_date: installation_date)

      low_station = s1.name

      expect(Station.station_with_fewest_bikes.name).to eq(low_station)
    end
  end

  describe 'class method' do
    it 'it shows most recently installed station' do
      name = 'Foo'
      name1 = 'Foo1'
      name2 = 'Mnaoj'
      dock_count = 5
      dock_count1 = 10
      dock_count2 = 15
      city = 'denver'
      installation_date = '08/12/23'
      installation_date1 = '09/12/23'
      installation_date2 = '10/12/23'

      s1 = Station.create(name: name, dock_count: dock_count, city: city, installation_date: installation_date)
      s2 = Station.create(name: name1, dock_count: dock_count1, city: city, installation_date: installation_date1)
      s3 = Station.create(name: name2, dock_count: dock_count2, city: city, installation_date: installation_date2)

      recent_station = s3.name

      expect(Station.most_recently_installed.name).to eq(recent_station)
    end
  end

  describe 'class method' do
    it 'it shows oldest station' do
      name = 'Foo'
      name1 = 'Foo1'
      name2 = 'Mnaoj'
      dock_count = 5
      dock_count1 = 10
      dock_count2 = 15
      city = 'denver'
      installation_date = '08/12/23'
      installation_date1 = '09/12/23'
      installation_date2 = '10/12/23'

      s1 = Station.create(name: name, dock_count: dock_count, city: city, installation_date: installation_date)
      s2 = Station.create(name: name1, dock_count: dock_count1, city: city, installation_date: installation_date1)
      s3 = Station.create(name: name2, dock_count: dock_count2, city: city, installation_date: installation_date2)

      oldest_station = s1.name

      expect(Station.oldest_station.name).to eq(oldest_station)
    end
  end
end
