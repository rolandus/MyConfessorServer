class CreateConfessionStatuses < ActiveRecord::Migration
  def change
    create_table :confession_statuses do |t|
      t.string :name

      t.timestamps
    end
  end
end
