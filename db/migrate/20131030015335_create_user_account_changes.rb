class CreateUserAccountChanges < ActiveRecord::Migration
  def change
    create_table :user_account_changes do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :password
      t.references :account_status
      t.string :email
      t.string :home_phone
      t.string :work_phone
      t.string :mobile_phone
      t.string :change_comments
      t.references :user_account, index: true

      t.timestamps
    end
  end
end
