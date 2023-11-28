class CreateActivities < ActiveRecord::Migration[7.1]
  def change
    create_table :activities do |t|
      t.string :name
      t.string :description
      t.string :address
      t.date :date
      t.float :price

      t.timestamps
    end
  end
end
