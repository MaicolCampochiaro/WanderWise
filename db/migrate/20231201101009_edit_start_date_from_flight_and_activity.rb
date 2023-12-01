class EditStartDateFromFlightAndActivity < ActiveRecord::Migration[7.1]
  def change
    change_column :flights, :start_date, :datetime
    change_column :activities, :date, :datetime
  end
end
