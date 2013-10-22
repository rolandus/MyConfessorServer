class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :home_phone
      t.string :mobile_phone
      t.string :email
      t.string :street_address
      t.string :city
      t.integer :state
      t.string :diocese
      t.string :parish
      t.string :password
      t.integer :office
      t.string :salutation
      t.binary :photo
      t.text :about_me
      t.integer :account_status
      t.integer :confessional_status
      t.references :confessional_location
      t.date :confessional_date
      t.time :confessional_start_time
      t.time :confessional_end_time
      t.text :confessional_details

      t.timestamps
    end
  end
end
