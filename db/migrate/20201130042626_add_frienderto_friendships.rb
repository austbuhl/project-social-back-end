class AddFriendertoFriendships < ActiveRecord::Migration[6.0]
  def change
    add_column :friendships, :friender_id, :integer
  end
end
