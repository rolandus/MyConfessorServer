class CreateConfessionLocationChanges < ActiveRecord::Migration
  def change
    create_table :confession_location_changes do |t|
      t.string :name
      t.string :nickname
      t.string :street_address
      t.string :city
      t.references :state
      t.string :postal_code
      t.string :change_comments
      t.references :user_account
      t.references :confession_location, index: true

      t.timestamps
    end
  end
end
