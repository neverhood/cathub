class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :likes_count, default: 0
      t.string  :description

      t.timestamps
    end
  end
end
