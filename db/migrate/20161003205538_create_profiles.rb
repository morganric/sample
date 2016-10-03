class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.text :bio
      t.string :image
      t.string :slug
      t.string :display_name
      t.string :twitter

      t.timestamps null: false
    end
  end
end
