class NullTrueOnReferencesTrip < ActiveRecord::Migration[7.1]
  def change
    change_column_null :trips, :users_id, true
    change_column_null :trips, :locations_id, true
  end
end
