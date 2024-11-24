class CreateUserChallenges < ActiveRecord::Migration[7.2]
  def change
    create_table :user_challenges do |t|
      t.references :user, null: false, foreign_key: true
      t.references :challenge, null: false, foreign_key: true
      t.boolean :completed
      t.datetime :completed_at

      t.timestamps
    end
  end
end
