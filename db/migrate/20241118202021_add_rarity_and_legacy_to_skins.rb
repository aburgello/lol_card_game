class AddRarityAndLegacyToSkins < ActiveRecord::Migration[7.2]
  def change
    add_column :skins, :rarity, :string
    add_column :skins, :is_legacy, :boolean
  end
end
