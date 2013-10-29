class CreateConfessorStatuses < ActiveRecord::Migration
  def change
    create_table :confessor_statuses do |t|
      t.string :name

      t.timestamps
    end
  end
end
