class CreateUserAccountChanges < ActiveRecord::Migration
  def change
    create_table :user_account_changes do |t|
      t.string :first_name
      t.string :last_name
      t.string :username #Can't be unique, because there will be multiple history lines for each user.
      t.string :password
      t.references :account_status #No need for an index here, since this is the history table.
      t.string :email
      t.string :home_phone
      t.string :work_phone
      t.string :mobile_phone
      t.references :confessor
      t.integer :changed_by_user_account_id
      t.string :change_comments
      t.references :user_account, index: true

      t.timestamps
    end
  end
end
