class AddStationToTrips < ActiveRecord::Migration[5.2]
  def change
    add_column :trips, :start_station_id, :integer
    add_index :trips, :start_station_id
    add_column :trips, :end_station_id, :integer
    add_index :trips, :end_station_id
  end
end
