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
end
