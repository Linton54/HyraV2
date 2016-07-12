class CreateInboxes < ActiveRecord::Migration
  def change
    create_table :inboxes do |t|
      t.integer :sender_id, index: true
      t.integer :receiver_id, index: true

      t.timestamps null: false
    end
    add_index :inboxes, [:sender_id, :receiver_id], unique: true
  end
end
