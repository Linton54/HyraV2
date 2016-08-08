class AddCounterCachePr < ActiveRecord::Migration
  def change
    add_column  :users, :posts_count, :integer, default: 0
    add_column  :users, :following_count, :integer, default: 0
    add_column  :users, :followers_count, :integer, default: 0

    #erase this when trying to roll back
    #also erase couter_cache: true for each model
    User.reset_column_information
    User.find_each do |u|
      u.update_attribute :posts_count, u.posts.length
      u.update_attribute :following_count, u.following.length
     u.update_attribute :followers_count, u.followers.length
    end
  end
end
