class CreateChampionsTypesJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :champions, :types do |t|
      # Uncomment the following lines if you want indices for faster lookup
      t.index :champion_id
      t.index :type_id
    end
  end
end
