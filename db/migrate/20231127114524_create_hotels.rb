class CreateHotels < ActiveRecord::Migration[7.1]
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :description
      t.string :address
      t.date :start_date
      t.date :end_date
      t.integer :guest
      t.float :price

      t.timestamps
    end
  end
end
