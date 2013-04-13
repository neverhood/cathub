class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.integer :post_id
      t.boolean :video, default: false
      t.boolean :gif,   default: false
      t.string  :url
      t.string  :image

      t.timestamps
    end

    add_index :media, :post_id
  end
end
