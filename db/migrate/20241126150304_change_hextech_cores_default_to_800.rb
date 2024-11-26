class ChangeHextechCoresDefaultTo800 < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :hextech_cores, from: 0, to: 800
  end
end
