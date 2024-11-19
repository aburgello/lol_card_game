class AddSplashArtCenteredToSkins < ActiveRecord::Migration[7.2]
  def change
    add_column :skins, :splash_art_centered, :string
  end
end
