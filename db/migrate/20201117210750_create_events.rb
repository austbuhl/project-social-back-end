class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :name
      t.string :description
      t.integer :num_of_people
      t.integer :event_activity_id

      t.timestamps
    end
  end
end
