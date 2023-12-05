class Alotofstuff < ActiveRecord::Migration[7.1]
  def change
    remove_column :activities, :date
    change_column :flights, :start_date, :date
    add_column :flights, :start_time, :time
    add_column :flights, :end_time, :time
  end
end
