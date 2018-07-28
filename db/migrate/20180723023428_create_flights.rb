class CreateFlights < ActiveRecord::Migration[5.2]
  def change
    create_table :flights do |t|
      t.string :origin_icao
      t.string :destination_icao
      t.string :fa_flight_id
      t.string :tail_number
      t.datetime :filed_departure_time
      t.datetime :estimated_departure_time
      t.datetime :actual_departure_time
      t.datetime :filed_arrival_time
      t.datetime :estimated_arrival_time
      t.datetime :actual_arrival_time
      t.boolean :blocked
      t.boolean :diverted
      t.boolean :cancelled
      t.timestamps
    end
  end
end
