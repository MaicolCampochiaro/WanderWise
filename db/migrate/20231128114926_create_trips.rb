class CreateTrips < ActiveRecord::Migration[7.1]
  def change
    create_table :trips do |t|
      t.string :name
      t.references :user, foreign_key: true, null: true
      t.references :location, foreign_key: true, null: true

      t.timestamps
    end
  end
end
