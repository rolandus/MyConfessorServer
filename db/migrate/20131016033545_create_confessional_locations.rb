class CreateConfessionalLocations < ActiveRecord::Migration
  def change
    create_table :confessional_locations do |t|
      t.string :name
      t.string :nickname
      t.string :street_address
      t.string :city
      t.integer :state

      t.timestamps
    end
  end
end
