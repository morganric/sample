class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.integer :user_id
      t.text :description
      t.text :samples
      t.string :image
      t.string :audio
      t.string :tag_list
      t.string :slug
      t.boolean :hidden
      t.boolean :disabled
      t.integer :plays
      t.integer :views
      t.string :slug

      t.timestamps null: false
    end
  end
end
