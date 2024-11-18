class AddFieldsToSkins < ActiveRecord::Migration[7.2]
  def change
    add_column :skins, :is_base, :boolean
    add_column :skins, :description, :text
  end
end
