class CreateAirfields < ActiveRecord::Migration[5.2]
  def change
    create_table :airfields do |t|
      t.string :icao
      t.string :iata
      t.string :name
      t.string :city
      t.string :state
      t.string :country
      t.integer :elevation
      t.float :lat
      t.float :lon
      t.string :tz

      t.timestamps
    end
  end
end
