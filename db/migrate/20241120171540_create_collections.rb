class CreateCollections < ActiveRecord::Migration[7.2]
  def change
    create_table :collections do |t|
      t.references :user, null: false, foreign_key: true
      t.references :skin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
