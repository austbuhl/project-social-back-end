class CreateEventActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :event_activities do |t|
      t.integer :event_id
      t.integer :activity_id

      t.timestamps
    end
  end
end
