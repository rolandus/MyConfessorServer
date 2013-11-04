class CreateConfessors < ActiveRecord::Migration
  def change
    create_table :confessors do |t|
      t.references :confessor_office
      t.string :salutation
      t.references :confession_status, index: true
      t.references :confession_location, index: true
      t.datetime :confession_start_time
      t.datetime :confession_end_time
      t.string :confession_comments
      t.text :biography

      t.timestamps
    end
  end
end
