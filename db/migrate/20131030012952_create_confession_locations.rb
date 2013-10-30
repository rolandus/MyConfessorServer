class CreateConfessionLocations < ActiveRecord::Migration
  def change
    create_table :confession_locations do |t|
      t.string :name
      t.string :nickname
      t.string :street_address, unique: true
      t.string :city, index: true
      t.references :state, index: true
      t.string :postal_code, index: true
      
      t.timestamps
    end
  end
end
