class RemmoveColumnsInContents < ActiveRecord::Migration[6.1]
  def change
    remove_column :contents, :move_id, :integer
    remove_column :contents, :move_time, :integer
  end
end
