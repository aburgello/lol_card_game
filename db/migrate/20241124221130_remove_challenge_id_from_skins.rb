class RemoveChallengeIdFromSkins < ActiveRecord::Migration[7.2]
  def change
    remove_column :skins, :challenge_id, :integer
  end
end
