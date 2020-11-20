class RemoveDateTimeColFromEvents < ActiveRecord::Migration[6.0]
  def change
    remove_column :events, :datetime, :datetime
  end
end
