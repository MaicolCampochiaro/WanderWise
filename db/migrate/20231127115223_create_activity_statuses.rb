class CreateActivityStatuses < ActiveRecord::Migration[7.1]
  def change
    create_table :activity_statuses do |t|
      t.integer :participant
      t.string :status
      t.references :activity, null: false, foreign_key: true
      t.references :trip, null: false, foreign_key: true

      t.timestamps
    end
  end
end
