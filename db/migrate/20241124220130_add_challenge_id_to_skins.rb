class AddChallengeIdToSkins < ActiveRecord::Migration[7.2]
  def change
    add_column :skins, :challenge_id, :integer
  end
end
