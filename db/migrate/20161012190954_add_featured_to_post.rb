class AddFeaturedToPost < ActiveRecord::Migration
  def change
    add_column :posts, :featured, :boolean
    add_column :posts, :hide_samples, :boolean
    add_column :posts, :downloadable, :boolean
    add_column :posts, :downloads, :integer
  end
end
