class AddHextechCoresToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :hextech_cores, :integer, default: 0, null: false
  end
end