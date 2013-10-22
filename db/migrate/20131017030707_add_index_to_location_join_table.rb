class AddIndexToLocationJoinTable < ActiveRecord::Migration
  def change
    change_table :user_locations do |t|
      t.index [:confessional_location_id, :user_id], unique: true
    end
  end
end
