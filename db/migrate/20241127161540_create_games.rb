class CreateGames < ActiveRecord::Migration[7.2]
  def change
    create_table :games do |t|
      t.string :name, null: false
      t.text :description
      t.integer :min_reward, null: false
      t.integer :max_reward, null: false
      t.integer :daily_plays_limit, default: 3
      t.string :game_type # 'quiz', 'ability_guess', 'skin_snippet', 'skin_name'
      t.jsonb :game_data, default: {} # Store questions, ability icons, skin snippets, etc.
      t.timestamps
    end

    create_table :game_plays do |t|
      t.references :user, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true
      t.integer :score
      t.integer :cores_earned
      t.datetime :played_at
      t.timestamps

      t.index [:user_id, :game_id, :played_at], name: 'index_game_plays_on_user_game_and_date'
    end
  end
end