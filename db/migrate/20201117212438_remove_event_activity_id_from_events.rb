class RemoveEventActivityIdFromEvents < ActiveRecord::Migration[6.0]
  def change
    remove_column :events, :event_activity_id, :integer
  end
end
