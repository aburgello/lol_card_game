class AddRegionIdToChallenges < ActiveRecord::Migration[7.0]
  def change
    add_reference :challenges, :region, foreign_key: true
  end
end
