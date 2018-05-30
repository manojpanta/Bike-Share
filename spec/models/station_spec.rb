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
end
