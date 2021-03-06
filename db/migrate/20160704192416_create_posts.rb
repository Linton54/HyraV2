class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.string :category
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :posts, [:created_at, :category]
  end
end
