class CreateAccountRoles < ActiveRecord::Migration
  def change
    create_table :account_roles do |t|
      t.string :name

      t.timestamps
    end
  end
end
