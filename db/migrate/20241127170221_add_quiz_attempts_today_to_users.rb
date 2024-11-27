class AddQuizAttemptsTodayToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :quiz_attempts_today, :integer, default: 0
  end
end
