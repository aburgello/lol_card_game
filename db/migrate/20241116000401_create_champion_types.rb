class CreateChampionTypes < ActiveRecord::Migration[7.2]
  def change
    create_table :champion_types do |t|
      t.references :champion, null: false, foreign_key: true
      t.references :type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
