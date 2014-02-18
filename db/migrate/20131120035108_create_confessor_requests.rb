class CreateConfessorRequests < ActiveRecord::Migration
  def change
    create_table :confessor_requests do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.references :diocese, index: true
      t.references :state, index: true
      t.references :confessor_request_status, index: true
      t.references :user_account, index: true
      t.text :comments
      t.string :confirmation_number, index: true, unique: true

      t.timestamps
    end
  end
end
