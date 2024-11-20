class CreateUserRegions < ActiveRecord::Migration[7.0]
  def change
    create_table :user_regions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :region, null: false, foreign_key: true
      t.datetime :discovered_at, null: false

      t.timestamps
    end

    # Ensure no duplicate regions for a user
    add_index :user_regions, [:user_id, :region_id], unique: true
  end
end