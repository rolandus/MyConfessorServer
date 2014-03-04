class AddDioceseToConfessionLocationChanges < ActiveRecord::Migration
  def change
    add_reference :confession_location_changes, :diocese, index: false
  end
end
