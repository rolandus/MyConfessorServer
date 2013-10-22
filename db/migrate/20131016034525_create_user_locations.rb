class CreateUserLocations < ActiveRecord::Migration
  def change
    create_table :user_locations do |t|
      t.references :user
      t.references :confessional_location
      t.text :location_details

      t.timestamps
    end
  end
end
