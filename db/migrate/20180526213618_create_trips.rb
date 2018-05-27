class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.integer :bike_id
      t.string :subscription_type
      t.integer :zip_code
      t.timestamps
    end
  end
end
