class CreateConfessorRequestChanges < ActiveRecord::Migration
  def change
    create_table :confessor_request_changes do |t|
      t.string :first_name
      t.string :last_name
      t.references :diocese
      t.references :state
      t.references :confessor_request_status
      t.text :change_comments
      t.integer :changed_by_user_account_id
      t.references :confessor_request, index: true

      t.timestamps
    end
  end
end
