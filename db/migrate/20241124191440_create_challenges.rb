class CreateChallenges < ActiveRecord::Migration[7.2]
  def change
    create_table :challenges do |t|
      t.string :name
      t.text :description
      t.string :reward
      t.string :progress_type
      t.integer :required_count

      t.timestamps
    end
  end
end
