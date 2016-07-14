class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :content
      t.string :recipient
      t.boolean :read, default: false
      t.references :inbox, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :messages, [:created_at]
  end
end
