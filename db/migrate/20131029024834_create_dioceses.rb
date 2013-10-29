class CreateDioceses < ActiveRecord::Migration
  def change
    create_table :dioceses do |t|
      t.string :name
      t.string :full_name
      t.references :state, index: true

      t.timestamps
    end
  end
end
