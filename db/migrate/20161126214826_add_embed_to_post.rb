class AddEmbedToPost < ActiveRecord::Migration
  def change
    add_column :posts, :embed_views, :integer
    add_column :posts, :card_views, :integer
  end
end
