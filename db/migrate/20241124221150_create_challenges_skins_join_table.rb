class CreateChallengesSkinsJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_table :challenges_skins, id: false do |t|
      t.belongs_to :challenge
      t.belongs_to :skin
    end
  end
end