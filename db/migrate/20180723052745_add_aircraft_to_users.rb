class AddAircraftToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :aircraft, :string, array:true, default: []
  end
end
