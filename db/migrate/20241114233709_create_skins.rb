class CreateSkins < ActiveRecord::Migration[7.2]
  def change
    create_table :skins do |t|
      t.references :champion, null: false, foreign_key: true
      t.string :name
      t.integer :num
      t.string :splash_art
      t.string :loading_art

      t.timestamps
    end
  end
end
