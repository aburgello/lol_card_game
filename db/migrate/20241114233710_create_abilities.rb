class CreateAbilities < ActiveRecord::Migration[7.2]
  def change
    create_table :abilities do |t|
      t.references :champion, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.string :image
      t.string :ability_type

      t.timestamps
    end
  end
end
