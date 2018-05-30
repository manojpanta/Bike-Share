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
      name2 = 'Foo2'
      dock_count = 5
      dock_count1 = 10
      dock_count2 = 15
      city = 'denver'
      installation_date = Time.now

      s1 = Station.create(name: name, dock_count: dock_count, city: city, installation_date: installation_date)
      s2 = Station.create(name: name1, dock_count: dock_count1, city: city, installation_date: installation_date)
      s3 = Station.create(name: name2, dock_count: dock_count2, city: city, installation_date: installation_date)

      top_station = s3.name

      expect(Station.station_with_most_bikes).to eq(top_station)
    end
  end
end
