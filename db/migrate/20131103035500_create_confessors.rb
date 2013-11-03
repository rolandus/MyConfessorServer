class CreateConfessors < ActiveRecord::Migration
  def change
    create_table :confessors do |t|
      t.references :confessor_office, index: true
      t.string :salutation
      t.references :confession_status, index: true
      t.references :confession_location, index: true, required: false
      t.datetime :confession_start_time, required: false
      t.datetime :confession_end_time, required: false
      t.string :confession_comments, required: false
      t.text :biography

      t.timestamps
    end
  end
end
