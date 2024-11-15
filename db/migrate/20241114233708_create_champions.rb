class CreateChampions < ActiveRecord::Migration[7.2]
  def change
    create_table :champions do |t|
      t.string :name
      t.string :title
      t.text :lore
      t.string :splash_art
      t.string :square_art
      t.string :passive_name
      t.text :passive_description
      t.string :passive_image

      t.timestamps
    end
  end
end
