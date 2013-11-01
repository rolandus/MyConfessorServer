class CreateConfessionLocations < ActiveRecord::Migration
  def change
    create_table :confession_locations do |t|
      t.string :name
      t.string :nickname
      t.string :street_address
      t.string :city, index: true
      t.references :state, index: true
      t.string :postal_code, index: true
      
      #You could end up have the same exact address and city name in two different states, 
      #so this prevents that. But it seems expensive, so we should do this with pre-save
      #validation of some sort.
      #t.index [:street_address, :city, :state], unique: true  
      
      t.timestamps
    end
  end
end
