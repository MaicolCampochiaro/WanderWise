class CreateFlightStatuses < ActiveRecord::Migration[7.1]
  def change
    create_table :flight_statuses do |t|
      t.string :status
      t.references :flight, null: false, foreign_key: true
      t.references :trip, null: false, foreign_key: true

      t.timestamps
    end
  end
end
