class CreateConfessorChanges < ActiveRecord::Migration
  def change
    create_table :confessor_changes do |t|
      t.references :confessor, index: true
      t.references :confessor_office
      t.references :diocese
      t.string :salutation
      t.references :user_account
      t.text :biography
      t.string :change_comments
      t.integer :changed_by_user_account_id

      t.timestamps
    end
  end
end
