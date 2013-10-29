class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :name, index: true
      t.string :abbreviation, index: true

      t.timestamps
    end
  end
end
