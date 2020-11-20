class AddDateAndTimeToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :date, :date
    add_column :events, :time, :time
  end
end
