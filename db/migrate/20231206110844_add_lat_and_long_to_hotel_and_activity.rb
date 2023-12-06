class AddLatAndLongToHotelAndActivity < ActiveRecord::Migration[7.1]
  def change
    add_column :hotels, :latitude, :float
    add_column :hotels, :longitude, :float
    add_column :activities, :latitude, :float
    add_column :activities, :longitude, :float
  end
end
