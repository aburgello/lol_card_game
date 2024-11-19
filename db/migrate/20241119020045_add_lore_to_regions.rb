class AddLoreToRegions < ActiveRecord::Migration[7.2]
  def change
    add_column :regions, :lore, :text
  end
end
