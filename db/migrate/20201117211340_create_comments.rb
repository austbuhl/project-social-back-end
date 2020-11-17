class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :event_id
      t.string :text

      t.timestamps
    end
  end
end
