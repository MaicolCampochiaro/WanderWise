class CreateFlights < ActiveRecord::Migration[7.1]
  def change
    create_table :flights do |t|
      t.string :start_location
      t.string :end_location
      t.date :start_date
      t.date :end_date
      t.float :price

      t.timestamps
    end
  end
end
