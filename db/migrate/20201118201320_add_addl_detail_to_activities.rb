class AddAddlDetailToActivities < ActiveRecord::Migration[6.0]
  def change
    add_column :activities, :addl_detail, :text
  end
end
