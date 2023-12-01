class AddLocationReferencesToActivityAndHotel < ActiveRecord::Migration[7.1]
  def change
    add_reference :activities, :location, foreign_key: true
    add_reference :hotels, :location, foreign_key: true
  end
end
