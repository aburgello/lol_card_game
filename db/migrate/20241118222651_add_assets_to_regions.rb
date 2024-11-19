class AddAssetsToRegions < ActiveRecord::Migration[7.2]
  def change
    add_column :regions, :logo, :string
    add_column :regions, :video_backdrop, :string
    add_column :regions, :image_backdrop, :string
  end
end
