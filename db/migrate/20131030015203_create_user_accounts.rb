class CreateUserAccounts < ActiveRecord::Migration
  def change
    create_table :user_accounts do |t|
      t.string :first_name
      t.string :last_name
      t.string :username, index: true, unique: true
      t.string :password
      t.references :account_status, index: true
      t.string :email,              :null => false, :default => ""
      t.string :home_phone
      t.string :work_phone
      t.string :mobile_phone

      t.timestamps
    end
    
    # Join table for linking accounts and roles.
    create_table :account_roles_user_accounts, id: false do |t|
      t.belongs_to :account_role
      t.belongs_to :user_account
    end
  end
end
