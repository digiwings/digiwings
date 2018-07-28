class CreateLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :logs do |t|
      t.string :aircraft
      t.string :reg
      t.time :start
      t.time :stop
      t.string :captain
      t.string :capacity
      t.string :from
      t.string :to

      t.timestamps
    end
  end
end
