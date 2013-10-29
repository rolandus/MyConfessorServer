class CreateConfessorOffices < ActiveRecord::Migration
  def change
    create_table :confessor_offices do |t|
      t.string :name

      t.timestamps
    end
  end
end
