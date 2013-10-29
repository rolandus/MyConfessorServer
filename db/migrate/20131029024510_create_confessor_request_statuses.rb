class CreateConfessorRequestStatuses < ActiveRecord::Migration
  def change
    create_table :confessor_request_statuses do |t|
      t.string :name

      t.timestamps
    end
  end
end
