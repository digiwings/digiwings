class AddSkydemonKeyToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :skydemon_key, :string
  end
end
