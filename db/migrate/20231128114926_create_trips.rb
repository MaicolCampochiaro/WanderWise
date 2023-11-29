class CreateTrips < ActiveRecord::Migration[7.1]
  def change
    create_table :trips do |t|
      t.string :name
      t.references :users, null: false, foreign_key: true
      t.references :locations, null: false, foreign_key: true

      t.timestamps
    end
  end
end
