class CreateUserChampions < ActiveRecord::Migration[7.2]
  def change
    create_table :user_champions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :champion, null: false, foreign_key: true

      t.timestamps
    end
  end
end
