class CreateRoomStatuses < ActiveRecord::Migration[7.1]
  def change
    create_table :room_statuses do |t|
      t.string :room_name
      t.date :start_date
      t.date :end_date
      t.integer :guest
      t.float :price
      t.string :status
      t.references :hotel, null: false, foreign_key: true
      t.references :trip, null: false, foreign_key: true

      t.timestamps
    end
  end
end
