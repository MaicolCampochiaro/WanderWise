class AddDateToActivityStatus < ActiveRecord::Migration[7.1]
  def change
    add_column :activity_statuses, :date, :date
  end
end
