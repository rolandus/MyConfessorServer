class AddDioceseToConfessionLocations < ActiveRecord::Migration
  def change
    add_reference :confession_locations, :diocese, index: true
  end
end
