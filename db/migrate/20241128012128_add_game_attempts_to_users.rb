class AddGameAttemptsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :ability_guess_attempts_today, :integer, default: 0
    add_column :users, :skin_snippet_attempts_today, :integer, default: 0
    add_column :users, :skin_name_attempts_today, :integer, default: 0
  end
end
