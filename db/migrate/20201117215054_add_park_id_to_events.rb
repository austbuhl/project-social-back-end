class AddParkIdToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :park_id, :integer
  end
end
