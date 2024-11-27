class Game < ApplicationRecord
  has_many :game_plays
  has_many :users, through: :game_plays

  validates :name, :min_reward, :max_reward, presence: true
  validates :min_reward, :max_reward, numericality: { greater_than_or_equal_to: 0 }
  validates :game_type, presence: true, inclusion: { in: %w[quiz ability_guess skin_snippet skin_name] }
  
  def calculate_reward(score)
    normalized_score = [score, 100].min / 100.0
    base_reward = min_reward + ((max_reward - min_reward) * normalized_score)
    base_reward.round
  end
end